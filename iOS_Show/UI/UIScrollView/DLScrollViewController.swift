//
//  DLScrollView.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/28.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollViewA: UIScrollView!
    var scrollViewB: UIScrollView!
    var pageControl: UIPageControl!
    let imageColor: NSArray = [UIColor.blue, UIColor.orange, UIColor.red, UIColor.purple]
    let imageArray: NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataSource()
        
        loadScrollView()
    }
    
    func loadScrollView() {
        DLprint("")
        
        // 单张图片的Scroll
        let labelA = UILabel(frame: CGRect(x: 20, y: 80, width: self.view.frame.size.width-20*2, height: 20))
        labelA.text = "单张图片的Scroll"
        self.view.addSubview(labelA)
        let imageViewA = UIImageView(frame: CGRect(x: 0, y: 0, width: 580, height: 380))
        imageViewA.image = UIImage(named: "scroll_A")
        
        scrollViewA = UIScrollView(frame: CGRect(x: 20, y: 100, width: self.view.frame.width-20*2, height: 200))
        scrollViewA.backgroundColor = UIColor.orange
        scrollViewA.addSubview(imageViewA)
        self.view.addSubview(scrollViewA)
        
        
        // 是否显示水平和竖直滚动条
        scrollViewA.showsHorizontalScrollIndicator = true
        scrollViewA.showsVerticalScrollIndicator = true
        // 可滚动区域
        scrollViewA.contentSize = imageViewA.frame.size
        // 当前显示的图片位置，scrollView左上角相对于图片左上角的坐标
        scrollViewA.contentOffset = CGPoint(x: 20, y: 50)
        // scrollView的contenView相对于scrollView的frame位置
        scrollViewA.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // 弹性效果
        scrollViewA.bounces = true
        // 当可滚动区域<=scrollView的Frame时，设置alwaysBounceVertical=true仍然会有弹性效果，前提是bounces = true
        scrollViewA.alwaysBounceVertical = true
        
        
        
        
        
        // 轮播图的Scroll
        let labelB = UILabel(frame: CGRect(x: 20, y: 350, width: self.view.frame.size.width-20*2, height: 20))
        labelB.text = "轮播图的Scroll"
        self.view.addSubview(labelB)
        
        scrollViewB = UIScrollView(frame: CGRect(x: 20, y: 370, width: self.view.frame.size.width-20*2, height: 200))
        scrollViewB.delegate = self
        scrollViewB.contentSize = CGSize(width: CGFloat(imageArray.count)*scrollViewB.frame.width, height: scrollViewB.frame.height)
        scrollViewB.isPagingEnabled = true
        scrollViewB.bounces = false
        scrollViewB.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollViewB)
        
        for i in 0..<imageArray.count {
            let imageView = UIImageView(frame: CGRect(x: scrollViewB.frame.width*CGFloat(i), y: 0, width: scrollViewB.frame.width, height: scrollViewB.frame.height))
            imageView.backgroundColor = imageArray[i] as? UIColor
            scrollViewB.addSubview(imageView)
        }
        scrollViewB.setContentOffset(CGPoint(x: scrollViewB.frame.width*1, y: 0), animated: false)
        
        
        var pageControlRect = scrollViewB.frame
        pageControlRect.origin.y = pageControlRect.origin.y + pageControlRect.size.height - 20
        pageControlRect.size.height = 20
        pageControl = UIPageControl(frame: pageControlRect)
        pageControl.numberOfPages = imageArray.count-2
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
        
    }
    
    func loadDataSource() {
        imageArray.add(imageColor[imageColor.count-1])
        for item in 0..<imageColor.count {
            imageArray.add(imageColor[item])
        }
        imageArray.add(imageColor[0])
        
        DLprint(imageArray)
    }
    
    
    //MARK: scroll view delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNum = scrollView.contentOffset.x / scrollView.frame.width
        if pageNum == CGFloat(imageArray.count-1) {
            pageNum = 1
        }
        else if pageNum == 0 {
            pageNum = CGFloat(imageArray.count - 2)
        }
        DLprint(pageNum)
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width*pageNum, y: 0), animated: false)
        pageControl.currentPage = Int(pageNum) - 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
