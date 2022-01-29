//
//  WeiHomeViewController.swift
//  swiftLearn
//
//  Created by lj on 2022/1/29.
//

import UIKit

class WeiBoHomeViewController: BaseViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {

    lazy var bgScrollView : UIScrollView = {
        var scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 2, height: self.view.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.blue
        return scrollView
    }()
    
    lazy var contentScrollView : UIScrollView = {
        var scrollView = UIScrollView.init(frame: CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.red
        scrollView.bounces = false
        return scrollView
    }()
    
    var pageData : Array = {
        return ["热门","春晚","同城","榜单","抗疫"];
    }()
    
    var colorArray : Array = {
        return [UIColor.systemRed,UIColor.systemBlue,UIColor.systemYellow,UIColor.systemGray,UIColor.systemPink];
    }()
    
    var lineView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.systemYellow
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        return view
    }()
    
    var isClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "微博"
        // Do any additional setup after loading the view.
        self.view.addSubview(self.bgScrollView)
        self.bgScrollView.addSubview(self.contentScrollView)
        self.satrtContentScrollView()
        self.navigationItem.titleView = self.creatTitleView()
    }
    
    func satrtContentScrollView() {
        self.contentScrollView.contentSize = CGSize(width: CGFloat(self.pageData.count) * self.view.frame.size.width, height: self.view.frame.size.height)
        for i in 0..<self.colorArray.count {
            let view = UIView(frame: CGRect(x: CGFloat(i) * self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            let nameLabel = UILabel()
            nameLabel.text = self.pageData[i]
            nameLabel.sizeToFit()
            nameLabel.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            view.addSubview(nameLabel)
            view.backgroundColor = self.colorArray[i]
            self.contentScrollView .addSubview(view)
        }
    }
    
    func creatTitleView() -> UIView {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleView.backgroundColor = UIColor.systemTeal
        let gzButton = UIButton()
        gzButton.setTitle("关注", for: UIControl.State.normal)
        gzButton.addTarget(self, action:#selector(gzButtonPressed(button:)), for: UIControl.Event.touchUpInside)
        gzButton.sizeToFit()
        gzButton.frame = CGRect(x: 10, y: (44-gzButton.frame.size.width)/2, width: gzButton.frame.size.width, height: gzButton.frame.size.height)
        gzButton.tag = 100
        titleView.addSubview(gzButton)
        
        let tjButton = UIButton()
        tjButton.setTitle("推荐", for: UIControl.State.normal)
        tjButton.addTarget(self, action:#selector(tjButtonPressed(button:)), for: UIControl.Event.touchUpInside)
        tjButton.sizeToFit()
        tjButton.frame = CGRect(x: gzButton.frame.maxX + 10, y: (44-gzButton.frame.size.width)/2, width: gzButton.frame.size.width, height: gzButton.frame.size.height)
        tjButton.tag = 101
        titleView.addSubview(tjButton)
        
        self.lineView.frame = CGRect(x: gzButton.frame.minX, y: gzButton.frame.maxY, width: gzButton.frame.size.width, height: 4);
        titleView.addSubview(self.lineView)
        return titleView
    }
    
    @objc func gzButtonPressed(button:UIButton) {
        self.isClick = true
        self.bgScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        UIView.animate(withDuration: 0.5) {
            self.lineView.frame = CGRect(x: button.frame.minX, y: button.frame.maxY, width: button.frame.size.width, height: self.lineView.frame.height)
        } completion: { (finish) in

        }
        print("111")
    }
    
    @objc func tjButtonPressed(button:UIButton) {
        self.isClick = true
        self.bgScrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
        UIView.animate(withDuration: 0.5) {
            self.lineView.frame = CGRect(x: button.frame.minX, y: button.frame.maxY, width: button.frame.size.width, height: self.lineView.frame.height)
        } completion: { (finish) in

        }
        print("222")
    }
    
    func scrollLineViewAnimate() {
        let gzButton = self.navigationItem.titleView?.viewWithTag(100)
        let tjButton = self.navigationItem.titleView?.viewWithTag(101)
        let width = self.view.frame.width
        let lineMaxWith = tjButton!.frame.minX - gzButton!.frame.minX
        
        if self.bgScrollView.contentOffset.x <= width/2 {
            let detal = self.bgScrollView.contentOffset.x * lineMaxWith / (width/2)
            self.lineView.frame = CGRect(x: gzButton!.frame.minX, y: gzButton!.frame.maxY, width: gzButton!.frame.size.width + detal, height: self.lineView.frame.height)
        } else {
            let detal = (self.bgScrollView.contentOffset.x - width/2) * lineMaxWith / (width/2)
            self.lineView.frame = CGRect(x: gzButton!.frame.minX + detal, y: gzButton!.frame.maxY, width: tjButton!.frame.maxX - gzButton!.frame.minX - detal, height: self.lineView.frame.height)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.bgScrollView {
            if !self.isClick {
                self.scrollLineViewAnimate()
            }
            if self.bgScrollView.contentOffset.x == 0 || self.bgScrollView.contentOffset.x == self.view.frame.size.width {
                self.isClick = false
            }
        }
    }
}
