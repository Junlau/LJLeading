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
        titleView.addSubview(gzButton)
        return titleView
    }
    
    @objc func gzButtonPressed(button:UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
