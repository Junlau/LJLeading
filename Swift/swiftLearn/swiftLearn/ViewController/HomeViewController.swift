//
//  HomeViewController.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/6/17.
//

import UIKit

class HomeViewController: BaseViewController, BannerViewDelegate, BannerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        
        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        bannerView.dataSource = self
        bannerView.delegate = self
        bannerView.timeInterval = 2
        bannerView.isAutoScroll = true
        view.addSubview(bannerView)
        
    }
    
    func didSelectBannerView(_ bannerView: BannerView, index: Int) {
        
    }
    
    func numberOfBanner(_ bannerView: BannerView) -> Int {
        return 4
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UILabel {
            view.text = String(index)
            return view
        } else {
            let label = UILabel()
            label.text = String(index)
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = UIColor.red
            label.textAlignment = .center
            return label
        }
    }
    
    
    
}
