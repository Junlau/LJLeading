//
//  BannerView.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/6/17.
//

import UIKit
import SnapKit

protocol BannerViewDataSource: AnyObject {
    func numberOfBanner(_ bannerView: BannerView) -> Int
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView
}

protocol BannerViewDelegate: AnyObject {
    func didSelectBannerView(_ bannerView: BannerView, index: Int)
}

class BannerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var collectionView: UICollectionView
    var flowLayout: UICollectionViewFlowLayout
    
    var pageControl: UIPageControl
    var timer: Timer?
    var timeInterval: Int = 3
    var isAutoScroll: Bool {
        didSet {
            if isAutoScroll {
                timer = Timer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(nextStep), userInfo: nil, repeats: true)
                RunLoop.current.add(timer!, forMode: .common)
            } else {
                if timer != nil {
                    timer!.invalidate()
                    timer = nil
                }
            }
        }
    }
    
    weak var dataSource: BannerViewDataSource? {
        didSet {
            collectionView.reloadData()
            //滚动到第一页
            DispatchQueue.main.async {
                //下一个runloop（等待reloadData完成）
                self.collectionView.setContentOffset(CGPoint(x: self.collectionView.frame.width, y: 0), animated: false)
            }
            pageControl.numberOfPages = dataSource!.numberOfBanner(self)
        }
    }
    weak var delegate: BannerViewDelegate?
    
    override init(frame: CGRect) {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout)
        
        pageControl = UIPageControl()
        
        isAutoScroll = false
        
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCellId")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.red
    }
    
    @objc func nextStep()  {
        guard let _ = superview, let _ = window else {
            return
        }

        let total = dataSource!.numberOfBanner(self)
        guard total > 1 else {
            return
        }
        
        let pageNumber = Int(round(collectionView.contentOffset.x/collectionView.frame.width))
        let nextPage = pageNumber + 1
        collectionView.setContentOffset(CGPoint(x: Int(collectionView.frame.width) * nextPage, y: 0), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataSource != nil {
            let number = self.dataSource!.numberOfBanner(self)
            if number <= 1 {
                return number
            } else {
                //前后各添加一个cell
                return number + 2
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCellId", for: indexPath)
        var convertView = cell.contentView.viewWithTag(100)
        var index = indexPath.item
        //默认循环滚动
        if self.dataSource!.numberOfBanner(self) > 1 {
            if index == 0 {
                index = self.dataSource!.numberOfBanner(self) - 1
            } else if index == self.dataSource!.numberOfBanner(self) + 1 {
                index = 0
            } else {
                index = index - 1
            }
        }
        
        if convertView != nil {
            let _ = self.dataSource!.viewForBanner(self, index: index, convertView: convertView)
        } else {
            convertView = self.dataSource!.viewForBanner(self, index: index, convertView: nil)
            convertView!.tag = 100
            cell.contentView.addSubview(convertView!)
            convertView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let current = scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.frame.width)
        if current == 0 {
            let total = dataSource!.numberOfBanner(self)
            if total > 1 {
                let pageNumber = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
                if pageNumber >= total + 1 {
                    scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: false)
                    pageControl.currentPage = 0
                } else if pageNumber <= 0 {
                    scrollView.setContentOffset(CGPoint(x: Int(scrollView.frame.width) * total, y: 0), animated: false)
                    pageControl.currentPage = total - 1
                } else {
                    pageControl.currentPage = pageNumber - 1
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
