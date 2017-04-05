//
//  LJTextView.m
//  LJDemo
//
//  Created by lj on 2017/3/16.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJTextView.h"
#import <CoreText/CoreText.h>
#import "LJTextLayout.h"

@interface LJTextView() {
    NSMutableArray *textFrameArray;
}

@end

@implementation LJTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        textFrameArray = [NSMutableArray array];
    }
    
    return self;
}

//修改指向的layer
+ (Class)layerClass {
    return [LJTextLayout class];
}

- (void)setDisplaysAsynchronously:(BOOL)displaysAsynchronously {
    _displaysAsynchronously = displaysAsynchronously;
    ((LJTextLayout *)self.layer).displaysAsynchronously = displaysAsynchronously;
}

- (void)setTextString:(NSMutableAttributedString *)textString {
    _textString = textString;
    [self.layer setNeedsDisplay];
}

//- (void)drawRect:(CGRect)rect {
//    
//    //直接绘制，YYLabel采用layer层绘制，实现异步绘制
//    
//    
//    
//}

#pragma mark - layer调用
- (void)drawTextAndImage:(CGContextRef)context size:(CGSize)size {
    NSMutableAttributedString *astring = _textString;
    //获取上下文
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置坐标系
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形的变换矩阵为不做图形变换
    //CGContextTranslateCTM(context, 0, self.bounds.size.height);//平移方法，将画布向上平移一个屏幕高度
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1, -1);//缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴为轴旋转180度
    
    //设置CTRun代理
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    
    callBacks.version = kCTRunDelegateVersion1;
    callBacks.getAscent = ascentCallbacks;
    callBacks.getDescent = descentCallbacks;
    callBacks.getWidth = widthCallbacks;
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (void *)astring);
    
    //创建空白字符
    unichar placeHolder = 0xFFFC;
    NSString *placeHolderString = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString *placeHolderAttributedString = [[NSMutableAttributedString alloc]initWithString:placeHolderString];
    
    //设置placeHolderAttributedString的Attributes 两种方式，通过Attributes判断是不是图片
    //1
    NSDictionary *attributedDic = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)delegate, kCTRunDelegateAttributeName,nil];
    [placeHolderAttributedString setAttributes:attributedDic range:NSMakeRange(0, 1)];
    
    //2
    //    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttributedString, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    
    CFRelease(delegate);
    
    //将图片插入
    [astring insertAttributedString:placeHolderAttributedString atIndex:astring.length/2];
    
    
    
    //创建path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    
    //绘文字
    CTFramesetterRef frameRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)astring);
    CTFrameRef fref = CTFramesetterCreateFrame(frameRef, CFRangeMake(0, astring.length), path, NULL);
    CTFrameDraw(fref, context);
    
    //绘图
    UIImage *image = [UIImage imageNamed:@"tj_Image"];
    CGRect imageRect = [self calculateImageRect:fref];
    CGContextDrawImage(context, imageRect, image.CGImage);
    
    CFRelease(path);
    CFRelease(fref);
    CFRelease(frameRef);
}


- (CGRect)calculateImageRect:(CTFrameRef)frame {
    //先找CTLine的原点，再找CTRun的原点
    NSArray *allLine = (NSArray *)CTFrameGetLines(frame);
    NSInteger lineCount = [allLine count];
    CGPoint points[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    CGRect imageRect = CGRectMake(0, 0, 0, 0);
    for (int i = 0; i < lineCount; i++) {
        CTLineRef line = (__bridge CTLineRef)allLine[i];
        //获取所有的CTRun
        CFArrayRef allRun = CTLineGetGlyphRuns(line);
        CFIndex runCount = CFArrayGetCount(allRun);
        
        //获取line原点
        CGPoint lineOrigin = points[i];
        
        
        for (int j = 0; j < runCount; j++) {
            CTRunRef run = CFArrayGetValueAtIndex(allRun, j);
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                NSString *textClickString = [attributes valueForKey:@"textClick"];
                if (textClickString != nil) {
                    [textFrameArray addObject:[NSValue valueWithCGRect:[self getLocWith:frame line:line run:run origin:lineOrigin]]];
                }
                
                continue;
            }
            imageRect = [self getLocWith:frame line:line run:run origin:lineOrigin];
        }
    }
    return imageRect;
}

- (CGRect)getLocWith:(CTFrameRef)frame line:(CTLineRef)line run:(CTRunRef)run origin:(CGPoint)point {
    CGRect boundRect;
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
    boundRect.size.width = width;
    boundRect.size.height = ascent + descent;
    
    //获取x偏移量
    CGFloat xoffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
    boundRect.origin.x = point.x + xoffset;
    boundRect.origin.y = point.y - descent;
    
    //获取BoundingBox
    CGPathRef path = CTFrameGetPath(frame);
    CGRect colRect = CGPathGetBoundingBox(path);

    return CGRectOffset(boundRect, colRect.origin.x, colRect.origin.y);
}

#pragma mark ---CTRUN代理---
CGFloat ascentCallbacks (void *ref) {
    return 11;
}

CGFloat descentCallbacks (void *ref) {
    return 7;
}

CGFloat widthCallbacks (void *ref) {
    return 36;
}

//将系统坐标转为屏幕坐标
- (CGRect)convertRectToWindow:(CGRect)rect {
    return CGRectMake(rect.origin.x, self.bounds.size.height - rect.origin.y - rect.size.height, rect.size.width, rect.size.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    [textFrameArray enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [value CGRectValue];
        CGRect convertRect = [self convertRectToWindow:rect];
        if (CGRectContainsPoint(convertRect, point)) {
            NSString *message = [NSString stringWithFormat:@"点击了%lu",(unsigned long)idx];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
}


#pragma mark - AppleDemo
//柱状图
- (CFArrayRef)createColumnsWithColumnCount:(int)columnCount
{
    int column;
    
    CGRect* columnRects = (CGRect*)calloc(columnCount, sizeof(*columnRects));
    // Set the first column to cover the entire view.
    columnRects[0] = self.bounds;
    
    // Divide the columns equally across the frame's width.
    CGFloat columnWidth = CGRectGetWidth(self.bounds) / columnCount;
    for (column = 0; column < columnCount - 1; column++) {
        CGRectDivide(columnRects[column], &columnRects[column],
                     &columnRects[column + 1], columnWidth, CGRectMinXEdge);
    }
    
    // Inset all columns by a few pixels of margin.
    for (column = 0; column < columnCount; column++) {
        columnRects[column] = CGRectInset(columnRects[column], 8.0, 15.0);
    }
    
    // Create an array of layout paths, one for each column.
    CFMutableArrayRef array =
    CFArrayCreateMutable(kCFAllocatorDefault,
                         columnCount, &kCFTypeArrayCallBacks);
    
    for (column = 0; column < columnCount; column++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, columnRects[column]);
        CFArrayInsertValueAtIndex(array, column, path);
        CFRelease(path);
    }
    free(columnRects);
    return array;
}

// Override drawRect: to draw the attributed string into columns.
// (In OS X, the drawRect: method of NSView takes an NSRect parameter,
//  but that parameter is not used in this listing.)
- (void)drawRect:(CGRect)rect
{
    // Initialize a graphics context in iOS.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the context coordinates in iOS only.
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Initializing a graphic context in OS X is different:
    // CGContextRef context =
    //     (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    // Set the text matrix.
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(
                                                                           (CFAttributedStringRef)self.textString);
    
    // Call createColumnsWithColumnCount function to create an array of
    // three paths (columns).
    CFArrayRef columnPaths = [self createColumnsWithColumnCount:3];
    
    CFIndex pathCount = CFArrayGetCount(columnPaths);
    CFIndex startIndex = 0;
    int column;
    
    // Create a frame for each column (path).
    for (column = 0; column < pathCount; column++) {
        // Get the path for this column.
        CGPathRef path = (CGPathRef)CFArrayGetValueAtIndex(columnPaths, column);
        
        // Create a frame for this column and draw it.
        CTFrameRef frame = CTFramesetterCreateFrame(
                                                    framesetter, CFRangeMake(startIndex, 0), path, NULL);
        CTFrameDraw(frame, context);
        
        // Start the next frame at the first character not visible in this frame.
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        startIndex += frameRange.length;
        CFRelease(frame);
        
    }
    CFRelease(columnPaths);
    CFRelease(framesetter);
}



@end
