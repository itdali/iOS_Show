//
//  DIY_ViewController.swift
//  iOS_Show
//
//  Created by dali on 2017/3/11.
//  Copyright © 2017年 dali. All rights reserved.
//
//坑：由于使用了SnapKit，导致视图的frame在viewDidAppear中才被确定，在此之前的修改圆角代码，由于视图frame没值，so不起作用
// 解决方案：1.在viewDidAppear中setCorner；2.不使用SnapKit......

import UIKit

class DIY_ViewController: UIViewController {
    
    var label: UILabel!
    var btn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAllUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DLprint(label.frame)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DLprint(label.frame)
        setCorner();
        super.viewDidAppear(animated)
    }
    
    func loadAllUI() {
        label = UILabel()
        label.text = ""
        //label.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        label.textAlignment = .center
        label.backgroundColor = UIColor.orange
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.clipsToBounds = true
        view.addSubview(label)
        
        btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = UIColor.blue
        view.addSubview(btn)
        
        
        label.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.center.equalTo(CGPoint(x: 150, y: 200))
        }
        
        btn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(label.snp.size)
            make.centerX.equalTo(label.snp.centerX)
            make.centerY.equalTo(label.snp.bottom).offset(100)
        }
        
        DLprint(label.frame)
        
    }
    
    func setCorner() {
        // 单个圆角
        let rect = label.bounds
        let radio = CGSize(width: 10, height: 10)
        let corner = UIRectCorner.bottomLeft
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corner, cornerRadii: radio)
        let masklayer = CAShapeLayer()
        masklayer.frame = label.bounds
        masklayer.path = path.cgPath
        label.layer.mask = masklayer
        
        
        // 单个圆角
        let rectB = btn.bounds
        let radioB = CGSize(width: 10, height: 10)
        let cornerB = UIRectCorner.bottomLeft
        let pathB = UIBezierPath.init(roundedRect: rectB, byRoundingCorners: cornerB, cornerRadii: radioB)
        let masklayerB = CAShapeLayer()
        masklayerB.frame = btn.bounds
        masklayerB.path = pathB.cgPath
        btn.layer.mask = masklayerB
        // 边框
        let borderLayer = CAShapeLayer()
        borderLayer.frame = btn.bounds
        borderLayer.path = pathB.cgPath
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        btn.layer.addSublayer(borderLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
