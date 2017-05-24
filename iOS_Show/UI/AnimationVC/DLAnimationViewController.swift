//
//  DLAnimationViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLAnimationViewController: UIViewController {
    
    
    @IBOutlet weak var actView: UIView!
    var basicAnimation: CABasicAnimation!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: CABasicAnimation - 基础动画
    @IBAction func ScaleAnimationButtonClick() {
        DLAnimation.animationScaleForView(actView, durationForAnimation: 0.8, fromValue: 1.0, toValue: 1.5, animationKey: "scaleAnimation")
    }
    
    @IBAction func RotateAnimationButtonClick() {
        DLAnimation.animationRotateForeverForView(actView, durationForAnimation: 1, animationKey: "rotateAnimation")
    }
    
    @IBAction func ShakeAnimationButtonClick() {
        DLAnimation.animationShakeForView(actView, animationKey: "shakeAnimation")
    }
    
    @IBAction func MoveAnimationButtonClick() {
        let startPosition = actView.center
        let endPosition = CGPoint(x: actView.center.x+100, y: actView.center.y+200)
        DLAnimation.animationStraightLineMoveForView(actView, durationForAnimation: 2, fromPosition: startPosition, toPosition: endPosition, animationKey: "moveAnimation")
    }
    
    @IBAction func FlipAnimationButtonClick() {
        DLAnimation.animationFlipForView(actView, durationForAnimation: 0.5, flipDirection: .vertical, animationKey: "flipAnimation")
    }
    
    @IBAction func MixtureAnimationButtonClick1() {
        let scaleAnimation = DLAnimation.animationScale(durationForAnimation: 1, fromValue: 1, toValue: 1.3)
        let flipAnimation = DLAnimation.animationFlip(durationForAnimation: 2, flipDirection: .vertical)
        let moveAnimation = DLAnimation.animationStraightLineMove(durationForAnimation: 2, fromPosition: actView.layer.position, toPosition: CGPoint(x: actView.layer.position.x+200, y: self.view.frame.size.height-250))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 2
        groupAnimation.autoreverses = true
        groupAnimation.animations = [scaleAnimation, flipAnimation, moveAnimation]
        groupAnimation.repeatCount = MAXFLOAT
        actView.layer.add(groupAnimation, forKey: "actViewAnimation")
    }
    
    @IBAction func MixtureAnimationButtonClick2() {
        resumeAnimation()
        let rotateAnimation = DLAnimation.animationRotateForever(durationForAnimation: 1)
        let flipAnimation = DLAnimation.animationFlip(durationForAnimation: 2, flipDirection: .horizontal)
        let moveAnimation = DLAnimation.animationStraightLineMove(durationForAnimation: 2, fromPosition: actView.layer.position, toPosition: CGPoint(x: actView.layer.position.x+200, y: self.view.frame.size.height-250))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 2
        groupAnimation.autoreverses = true
        groupAnimation.animations = [rotateAnimation, flipAnimation, moveAnimation]
        groupAnimation.repeatCount = MAXFLOAT
        actView.layer.add(groupAnimation, forKey: "actViewAnimation")
    }
    
    
    //MARK: CAKeyframeAnimation - 自定义动画
    @IBAction func rectangleMoveAnimation() {
        let positions = [
            NSValue(cgPoint: actView.center),
            NSValue(cgPoint: CGPoint(x: actView.center.x+200, y: actView.center.y)),
            NSValue(cgPoint: CGPoint(x: actView.center.x+200, y: actView.center.y+200)),
            NSValue(cgPoint: CGPoint(x: actView.center.x, y: actView.center.y+200)),
            NSValue(cgPoint: actView.center)]
        // keyTimes第一个数必须0, 最后一个必须1, 中间的递增, 表示整个动画从0到1时间的过程
        // 不设置的话默认每段就是: duration/边数
        let keyTimes = [
            NSNumber(value: 0.0 as Float),
            NSNumber(value: 0.6 as Float),
            NSNumber(value: 0.7 as Float),
            NSNumber(value: 0.8 as Float),
            NSNumber(value: 1.0 as Float)]
        DLAnimation.animationPolygonMoveForView(actView, durationForAnimation: 3, trackPositions: positions, keyTimes: keyTimes, animationKey: "rectangleMove")
    }
    
    @IBAction func triangleMoveAnimation() {
        let positions = [
            NSValue(cgPoint: actView.center),
            NSValue(cgPoint: CGPoint(x: actView.center.x+200, y: actView.center.y+150)),
            NSValue(cgPoint: CGPoint(x: actView.center.x, y: actView.center.y+300)),
            NSValue(cgPoint: actView.center)]
        // keyTimes第一个数必须0, 最后一个必须1, 中间的递增, 表示整个动画从0到1时间的过程
        // 不设置的话默认每段就是: duration/边数
        let keyTimes = [
            NSNumber(value: 0.0 as Float),
            NSNumber(value: 0.4 as Float),
            NSNumber(value: 0.8 as Float),
            NSNumber(value: 1.0 as Float)]
        DLAnimation.animationPolygonMoveForView(actView, durationForAnimation: 3, trackPositions: positions, keyTimes: keyTimes, animationKey: "triangleMove")
        
    }
    
    @IBAction func throwMoveAnimation() {
        DLAnimation.animationThrowLineMoveForView(actView, durationForAnimation: 1, fromPosition: actView.center, toPosition: CGPoint(x: actView.center.x+200, y: actView.center.y+200), heightDifference: 200, animationKey: "throwLineMove")
    }
    
    @IBAction func ellipseMoveAnimation() {
        let center = CGPoint(x: 200, y: 200)
        let ellipseMove = DLAnimation.animationEllipseMove(durationForAnimation: 8, centerPosition: center, ellipseSize: CGSize(width: 100, height: 150))
        actView.layer.add(ellipseMove, forKey: "ellipseMove")
        //DLAnimation.resumeAnimation(animationView: actView)
    }
    
    @IBAction func circleMoveAnimation() {
//        let center = CGPointMake(200, 200)
//        let circleMove = DLAnimation.animationCircleMove(durationForAnimation: 2, centerPosition: center, circleRadius: 150)
//        actView.layer.addAnimation(circleMove, forKey: "ellipseMove")
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func pauseAnimation() {
        DLAnimation.pauseAnimation(animationView: actView)
    }
    
    @IBAction func resumeAnimation() {
        DLAnimation.resumeAnimation(animationView: actView)
    }
    
    @IBAction func removeAnimation() {
        DLAnimation.removeAllAnimation(animationView: actView)
    }
    
    
    @IBAction func backButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
