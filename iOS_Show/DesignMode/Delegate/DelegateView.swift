//
//  DelegateView.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

public protocol DLViewDelegate: NSObjectProtocol {
    func delegateView(_ view: UIView, button: UIButton)
}


class DelegateView: UIView {

    weak var delegate: DLViewDelegate!
    var button: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        button.setTitle("点我触发代理事件", for: UIControlState())
        button.setTitleColor(UIColor.blue, for: UIControlState())
        button.addTarget(self, action: #selector(DelegateView.buttonClick), for: .touchUpInside)
        self.addSubview(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buttonClick() {
        if delegate != nil {
            delegate.delegateView(self, button: button)
        }
    }

}
