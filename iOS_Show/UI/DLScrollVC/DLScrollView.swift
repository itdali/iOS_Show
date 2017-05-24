//
//  DLScrollView.swift
//  iOS_Show
//
//  Created by dali on 16/10/8.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit


class DLScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{

    private var collectionView: UICollectionView!
    private var dataArray: NSMutableArray = ["", "", ""]
    private var pageNum: UILabel!
    private var currentPage: Int = 0
    private let cellID = "DLScrollCellID"
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        //collectionView.register(UINib(nibName: "DLCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.register(DLScrollViewCell.self, forCellWithReuseIdentifier: cellID)
        self.addSubview(collectionView)
        
        // 页码 label
        pageNum = UILabel(frame: CGRect(x: (frame.size.width-50)*0.5, y: (frame.size.height-20), width: 50, height: 20))
        pageNum.textColor = UIColor.darkGray
        pageNum.textAlignment = .center
        pageNum.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        self.addSubview(pageNum)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Collection View Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DLScrollViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DLScrollViewCell
        cell.imageView.image = UIImage(named: dataArray[indexPath.row] as! String)
        return cell
    }
    
    //MARK:- Collection View Delegate
    // Cell外边距
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    // 左右item最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 上下两行item最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }*/
    
    //MARK:- UIScroll View Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let point: CGPoint = self.convert(collectionView.center, to: collectionView)
        let indexPath: IndexPath = collectionView.indexPathForItem(at: point)!
        currentPage = indexPath.row
        DLprint(currentPage)
        if currentPage == 0 {
            scrollToItem(at: dataArray.count-2)
        }
        if currentPage == dataArray.count-1 {
            scrollToItem(at: 1)
        }
        pageNum.text = "\(currentPage)/\(dataArray.count-2)"
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            DLprint(cell)
        }
    }
    // 滑动到制定 Item
    private func scrollToItem(at item: Int) {
        let indexPath:IndexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        scrollViewDidEndDecelerating(collectionView)
    }
    
    //MARK:- DLScroll function
    // 刷新数据
    internal func reloadData(data: NSMutableArray) {
        dataArray.removeAllObjects()
        dataArray.add(data[data.count-1])
        for item in data { dataArray.add(item) }
        dataArray.add(data[0])
        collectionView.reloadData()
        scrollToItem(at: 1)
    }
}
