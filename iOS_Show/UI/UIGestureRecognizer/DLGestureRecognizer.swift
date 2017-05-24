//
//  DLGestureRecognizer.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/27.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLGestureRecognizer: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var tapOnceLabel: UILabel!
    @IBOutlet weak var tapTwiceLabel: UILabel!
    @IBOutlet weak var longPressLabel: UILabel!
    @IBOutlet weak var swipeLeftLabel: UILabel!
    @IBOutlet weak var swipeRightLabel: UILabel!
    @IBOutlet weak var swipeAllDirectionLabel: UILabel!
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var pinchLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var showLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
    }
    
    func addGesture() {
        
        // 单击
        let tapOnce = UITapGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.tapClick(_:)))
        tapOnce.numberOfTapsRequired = 1
        tapOnceLabel.isUserInteractionEnabled = true
        tapOnceLabel.addGestureRecognizer(tapOnce)
        
        
        // 双击
        let tapTwice = UITapGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.tapClick(_:)))
        tapTwice.numberOfTapsRequired = 2
        tapTwiceLabel.isUserInteractionEnabled = true
        tapTwiceLabel.addGestureRecognizer(tapTwice)
        
        
        // 长按
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.longPressClick(_:)))
        longPress.minimumPressDuration = 1
        // 手势失败之前允许的手指最大运动像素
        longPress.allowableMovement = 10
        longPressLabel.isUserInteractionEnabled = true
        longPressLabel.addGestureRecognizer(longPress)
        
        
        // 向左轻扫
        let swipeTempLeft = UISwipeGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.swipeClick(_:)))
        swipeTempLeft.direction = .left
        swipeLeftLabel.isUserInteractionEnabled = true
        swipeLeftLabel.addGestureRecognizer(swipeTempLeft)
        
        // 向右轻扫
        let swipeTempRight = UISwipeGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.swipeClick(_:)))
        swipeTempRight.direction = .right
        swipeRightLabel.isUserInteractionEnabled = true
        swipeRightLabel.addGestureRecognizer(swipeTempRight)
        
        
        // 上下左右皆可扫
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.swipeClick(_:)))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.swipeClick(_:)))
        swipeRight.direction = .right
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.swipeClick(_:)))
        swipeUp.direction = .up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.swipeClick(_:)))
        swipeDown.direction = .down
        swipeAllDirectionLabel.isUserInteractionEnabled = true
        swipeAllDirectionLabel.addGestureRecognizer(swipeLeft)
        swipeAllDirectionLabel.addGestureRecognizer(swipeRight)
        swipeAllDirectionLabel.addGestureRecognizer(swipeUp)
        swipeAllDirectionLabel.addGestureRecognizer(swipeDown)
        
        
        // 拖动
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.panClick(_:)))
        panLabel.isUserInteractionEnabled = true
        panLabel.addGestureRecognizer(pan)
        
        
        // 捏合
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.pinchClick(_:)))
        pinchLabel.isUserInteractionEnabled = true
        pinchLabel.addGestureRecognizer(pinch)
        
        
        // 旋转
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(DLGestureRecognizer.rotationClick(_:)))
        rotationLabel.isUserInteractionEnabled = true
        rotationLabel.addGestureRecognizer(rotation)
    }

    
    func tapClick(_ sender: UITapGestureRecognizer) {
        showLabel.text = sender.numberOfTapsRequired == 1 ? "单击手势" : "双击手势"
    }
    
    func longPressClick(_ sender: UILongPressGestureRecognizer) {
        showLabel.text = "长按"
    }
    
    func swipeClick(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.left:
            showLabel.text = "向左轻扫"
        case UISwipeGestureRecognizerDirection.right:
            showLabel.text = "向右轻扫"
        case UISwipeGestureRecognizerDirection.up:
            showLabel.text = "向上轻扫"
        case UISwipeGestureRecognizerDirection.down:
            showLabel.text = "向下轻扫"
        default:
            showLabel.text = ""
        }
    }
    
    func panClick(_ sender: UIPanGestureRecognizer) {
        showLabel.text = "拖拽手势"
        let translation = sender.translation(in: self.view)
        sender.view?.center = CGPoint(x: (sender.view?.center.x)! + translation.x, y: (sender.view?.center.y)! + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func pinchClick(_ sender: UIPinchGestureRecognizer) {
        showLabel.text = "捏合手势"
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    func rotationClick(_ sender: UIRotationGestureRecognizer) {
        showLabel.text = "旋转手势"
        sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
