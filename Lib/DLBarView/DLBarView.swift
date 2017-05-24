//
//  DLBarView.swift
//  UIShow_Swift
//
//  Created by dali on 16/8/30.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

public protocol DLBarViewDelegate: NSObjectProtocol {
    /**
     barView点击按钮代理方法
     
     - parameter barView:  点击的barView
     - parameter barIndex: barView的index
     */
    func barView(barView:UIView, barIndex: Int)
}

class DLBarView: UIView {
    
    weak var delegate: DLBarViewDelegate!
    fileprivate var barBtns: NSMutableArray = []
    fileprivate var barTitles: NSMutableArray = []
    
    var barArray: NSArray = [] {
        willSet {
            DLprint("barArray - willSet")
        }
        didSet {
            DLprint("barArray - didSet")
            for i in 0..<barArray.count {
                let tempBtn = barBtns[i] as! UIButton
                let tempTitle = barTitles[i] as! UILabel
                let itemArray = barArray[i] as! NSArray
                tempBtn.setTitle(itemArray[0] as? String, for: UIControlState())
                tempTitle.text = itemArray[1] as? String
            }
        }
    }
    
    // 重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.orange
        
        let barBG_W: CGFloat = frame.size.width * 0.25
        let barBG_H: CGFloat = frame.size.height
        let barImg_W_H: CGFloat = (barBG_W > barBG_H ? barBG_H - 30 : barBG_W - 30)
        let barImg_X: CGFloat = (barBG_W - barImg_W_H) * 0.5
        
        for i in 0...3 {
            let barBG = UIView(frame: CGRect(x: CGFloat(i)*barBG_W, y: 0, width: barBG_W, height: barBG_H))
            self.addSubview(barBG)
            
            let barBtn = UIButton(frame: CGRect(x: barImg_X, y: 10, width: barImg_W_H, height: barImg_W_H))
            barBtn.addTarget(self, action: #selector(DLBarView.barBtnClick(_:)), for: .touchUpInside)
            barBtn.layer.cornerRadius = 5
            barBtn.clipsToBounds = true
            barBtn.tag = i+100
            barBG.addSubview(barBtn)
            
            
            let barTitle = UILabel(frame: CGRect(x: 0, y: barBtn.frame.maxY+2, width: barBG_W, height: 14))
            barTitle.textAlignment = .center
            barTitle.font = UIFont.systemFont(ofSize: 14)
            barTitle.text = "abcde"
            barBG.addSubview(barTitle)
            
            barBtns.add(barBtn)
            barTitles.add(barTitle)
            
            // 辅助用颜色，后期删除
            barBG.backgroundColor = UIColor.green
            barBtn.backgroundColor = UIColor.red
        }
    }
    
    // 反正重写了init方法这个会根据提示自动蹦出来
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 点击事件
    func barBtnClick(_ sender: UIButton) {
        if delegate != nil {
            delegate.barView(barView: self, barIndex: sender.tag-100)
        }
    }

}
