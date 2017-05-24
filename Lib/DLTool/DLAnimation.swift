//
//  DLAnimation.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/26.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit


public enum DLAnimationFlipDirection : Int {
    case vertical //上下翻动
    case horizontal //左右翻动
}
/*
keyPath可以使用的key

- #define angle2Radian(angle) ((angle)/180.0*M_PI)
- transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)
transform.rotation.y 围绕y轴翻转 参数：同上
transform.rotation.z 围绕z轴翻转 参数：同上
transform.rotation 默认围绕z轴
transform.scale.x x方向缩放 参数：缩放比例 1.5
transform.scale.y y方向缩放 参数：同上
transform.scale.z z方向缩放 参数：同上
transform.scale 所有方向缩放 参数：同上
transform.translation.x x方向移动 参数：x轴上的坐标 100
transform.translation.y x方向移动 参数：y轴上的坐标
transform.translation.z x方向移动 参数：z轴上的坐标
transform.translation 移动 参数：移动到的点 （100，100）
*/

class DLAnimation: CAAnimation {
    
    
    //================================================================
    //MARK: Create Animation
    //================================================================
    
    /**
     Rotate Animation Forever - 一直旋转
     
     - parameter duration: Duration Time For Once
     
     - returns: CABasicAnimation OBJ
     */
    internal class func animationRotateForever(durationForAnimation duration:CFTimeInterval) -> CABasicAnimation {
        // keyPath: 决定基础动画的类型，该值不能随便取，一旦取错就达不到想要的效果
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.fromValue = NSNumber(value: 0 as Double)
        rotateAnimation.toValue = NSNumber(value: 2*Double.pi as Double)
        //autoreverse: 当动画执行到toValue指定的状态时是从toValue的状态逆回去，还是重新执行
        rotateAnimation.autoreverses = false
        /*
        kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
        kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
        kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态。因为有可能出现fromValue不是目前layer的初始状态的情况，如果fromValue就是layer当前的状态，则这个参数就没太大意义。
        kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
        */
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.repeatCount = MAXFLOAT
        rotateAnimation.duration = duration
        return rotateAnimation
    }
    
    /**
     Shake Animation - 抖动
     
     - returns: CABasicAnimation OBJ
     */
    internal class func animationShake() -> CABasicAnimation {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        shakeAnimation.fromValue = NSNumber(value: -0.01*Double.pi as Double)
        shakeAnimation.toValue = NSNumber(value: 0.01*Double.pi as Double)
        shakeAnimation.autoreverses = true
        //shakeAnimation.fillMode = kCAFillModeForwards
        //shakeAnimation.removedOnCompletion = false
        shakeAnimation.repeatCount = MAXFLOAT
        shakeAnimation.duration = 0.1
        return shakeAnimation
    }
    
    /**
     Scale Animation - 缩放
     
     - parameter duration:  Duration Time For Once
     - parameter fromValue: Begin Status Value
     - parameter toValue:   End Status Value
     
     - returns: CABasicAnimation OBJ
     */
    internal class func animationScale(durationForAnimation duration:CFTimeInterval, fromValue:Double, toValue:Double) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.autoreverses = true
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.duration = duration
        return scaleAnimation
    }
    
    
    /**
     Flip Animation - 翻转：水平或者竖直
     
     - parameter duration:  Duration Time For Once
     - parameter direction: Flip Direction: Vertical or Horizontal
     
     - returns: CABasicAnimation OBJ
     */
    internal class func animationFlip(durationForAnimation duration:CFTimeInterval, flipDirection direction: DLAnimationFlipDirection) -> CABasicAnimation {
        let flipAnimation = CABasicAnimation(keyPath: (direction == DLAnimationFlipDirection.vertical ? "transform.rotation.x" : "transform.rotation.y" ))
        flipAnimation.fromValue = NSNumber(value: 0 as Double)
        flipAnimation.toValue = NSNumber(value: 2*Double.pi as Double)
        flipAnimation.autoreverses = false
        flipAnimation.fillMode = kCAFillModeForwards
        flipAnimation.isRemovedOnCompletion = false
        flipAnimation.repeatCount = MAXFLOAT
        flipAnimation.duration = duration
        return flipAnimation
    }
    
    /**
     Straight Line Move Animation - 直线移动
     
     - parameter duration: Duration Time For Once
     - parameter from:     Begin Position
     - parameter to:       End Position
     
     - returns: CABasicAnimation OBJ
     */
    internal class func animationStraightLineMove(durationForAnimation duration:CFTimeInterval, fromPosition from:CGPoint, toPosition to: CGPoint) -> CABasicAnimation {
        let lineMove = CABasicAnimation(keyPath: "position")
        lineMove.fromValue = NSValue(cgPoint: from)
        lineMove.toValue = NSValue(cgPoint: to)
        lineMove.autoreverses = true
        lineMove.fillMode = kCAFillModeForwards
        lineMove.isRemovedOnCompletion = false
        lineMove.repeatCount = MAXFLOAT
        lineMove.duration = duration
        return lineMove
    }
    
    
    /**
    Polygon Move Animation - 多边形移动
    
    - parameter duration:  Duration Time For Once
    - parameter positions: Every Position
    - parameter times:     Time For Every Side
    keyTimes第一个数必须0, 最后一个必须1, 中间的递增, 表示整个动画从0到1时间的过程
    不设置的话默认每段就是: duration/边数
    
    - returns: CAKeyframeAnimation OBJ
    */
    internal class func animationPolygonMove(durationForAnimation duration:CFTimeInterval,trackPositions positions:[NSValue], keyTimes times:[NSNumber]?) -> CAKeyframeAnimation  {
        let polygonMove = CAKeyframeAnimation(keyPath: "position")
        polygonMove.values = positions
        if times != nil {
            polygonMove.keyTimes = times
        }
        /*
        polygonMove.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
        */
        polygonMove.repeatCount = MAXFLOAT
        polygonMove.autoreverses = false
        polygonMove.calculationMode = kCAAnimationLinear
        polygonMove.duration = duration
        return polygonMove
    }
    
    
    /**
     Throw Line Move Animation - 抛物线移动
     
     - parameter duration: Duration Time For Once
     - parameter from:     Start Position
     - parameter to:       End Position
     - parameter height:   The highest position.y - higher(start.y , end.y)
     
     - returns: CAKeyframeAnimation OBJ
     */
    internal class func animationThrowLineMove (durationForAnimation duration:CFTimeInterval, fromPosition from:CGPoint, toPosition to:CGPoint, heightDifference height:CGFloat) -> CAKeyframeAnimation   {
        let throwPath = CGMutablePath()
        throwPath.move(to: CGPoint(x: from.x, y: from.y))
        throwPath.addQuadCurve(to: CGPoint(x: (from.x + to.x)*0.5, y: -height), control: CGPoint(x: to.x, y: to.y))
        let throwLineMove = CAKeyframeAnimation(keyPath: "position")
        throwLineMove.path = throwPath
        throwLineMove.repeatCount = MAXFLOAT
        throwLineMove.duration = duration
        throwLineMove.isRemovedOnCompletion = false
        return throwLineMove
    }
    
    
    
    
    //测试阶段，不可用
    
    internal class func animationEllipseMove (durationForAnimation duration:CFTimeInterval, centerPosition center:CGPoint, ellipseSize size:CGSize) -> CAKeyframeAnimation {
        let ellipsePath = CGMutablePath()
        ellipsePath.move(to: CGPoint(x: center.x, y: center.y-size.height*0.5))
        ellipsePath.addEllipse(in: CGRect(x: center.x, y: center.y, width: size.width, height: size.height))
        let ellipseMove = CAKeyframeAnimation(keyPath: "position")
        ellipseMove.path = ellipsePath
        ellipseMove.repeatCount = MAXFLOAT
        ellipseMove.duration = duration
        ellipseMove.isRemovedOnCompletion = false
        return ellipseMove
    }
    
    internal class func animationCircleMove (durationForAnimation duration:CFTimeInterval, centerPosition center:CGPoint, circleRadius radius:CGFloat) -> CAKeyframeAnimation {
        return animationEllipseMove(durationForAnimation: duration, centerPosition: center, ellipseSize: CGSize(width: radius, height: radius))
    }
    
    
    
    
    //================================================================
    //MARK: Add animation to view
    //================================================================
    
    /**
     Add rotate animation to view - 给视图添加一直旋转的动画
     
     - parameter view:     View
     - parameter duration: Duration Time For Once
     - parameter key:      Animation Key
     */
    internal class func animationRotateForeverForView(_ view:UIView, durationForAnimation duration:CFTimeInterval, animationKey key:String){
        view.layer.add(animationRotateForever(durationForAnimation: 0.8), forKey: key)
        resumeAnimation(animationView: view)
    }
    
    /**
     Add shake animation to view - 给视图添加抖动动画
     
     - parameter view: View
     - parameter key:  Animation Key
     */
    internal class func animationShakeForView(_ view:UIView, animationKey key:String){
        view.layer.add(animationShake(), forKey: key)
        resumeAnimation(animationView: view)
    }
    
    /**
     Add scale animation to view - 给视图添加缩放动画
     
     - parameter view:      View
     - parameter duration:  Duration Time For Once
     - parameter fromValue: Begin Status Value
     - parameter toValue:   End Status Value
     - parameter key:       Animation Key
     */
    internal class func animationScaleForView(_ view:UIView, durationForAnimation duration:CFTimeInterval, fromValue:Double, toValue:Double, animationKey key:String){
        view.layer.add(animationScale(durationForAnimation: duration, fromValue: fromValue, toValue: toValue), forKey: key)
        resumeAnimation(animationView: view)
    }
    
    
    /**
     Add move animation to view - 给视图添加翻转动画
     
     - parameter view:      View
     - parameter duration:  Duration Time For Once
     - parameter direction: Flip Direction: Vertical or Horizontal
     - parameter key:       Animation Key
     */
    internal class func animationFlipForView(_ view:UIView, durationForAnimation duration:CFTimeInterval, flipDirection direction: DLAnimationFlipDirection, animationKey key:String) {
        view.layer.add(animationFlip(durationForAnimation: duration, flipDirection: direction), forKey: key)
        resumeAnimation(animationView: view)
    }
    
    /**
     Add straight line move animation to view - 给视图添加直线移动动画
     
     - parameter view:     View
     - parameter duration: Duration Time For Once
     - parameter from:     Begin Position
     - parameter to:       End Position
     - parameter key:      Animation Key
     */
    internal class func animationStraightLineMoveForView(_ view:UIView, durationForAnimation duration:CFTimeInterval, fromPosition from:CGPoint, toPosition to: CGPoint, animationKey key:String){
        view.layer.add(animationStraightLineMove(durationForAnimation: duration, fromPosition: from, toPosition: to), forKey: key)
        resumeAnimation(animationView: view)
    }
    
    
    /**
     Add polygon move animation to view - 给视图添加多边形移动动画
     
     - parameter view:      View
     - parameter duration:  Duration Time For Once
     - parameter positions: Every Position
     - parameter times:     Time For Every Side
     - parameter key:       Animation Key
     */
    internal class func animationPolygonMoveForView(_ view:UIView, durationForAnimation duration:CFTimeInterval,trackPositions positions:[NSValue], keyTimes times:[NSNumber]?, animationKey key:String) {
        view.layer.add(animationPolygonMove(durationForAnimation: duration, trackPositions: positions, keyTimes: times), forKey: key)
        resumeAnimation(animationView: view)
    }
    
    /**
     Add throw line move animation to view - 给视图添加抛物线移动动画
     
     - parameter view:     View
     - parameter duration: Duration Time For Once
     - parameter from:     Start Position
     - parameter to:       End Position
     - parameter height:   The highest position.y - higher(start.y , end.y)
     - parameter key:      Animation Key
     */
    internal class func animationThrowLineMoveForView(_ view:UIView, durationForAnimation duration:CFTimeInterval, fromPosition from:CGPoint, toPosition to:CGPoint, heightDifference height:CGFloat, animationKey key:String) {
        view.layer.add(animationThrowLineMove(durationForAnimation: duration, fromPosition: from, toPosition: to, heightDifference: height), forKey: key)
    }
    
    
    //================================================================
    //MARK: Animation Tool
    //================================================================

    /**
    Pause Animation For View
    
    - parameter view: View
    */
    internal class func pauseAnimation(animationView view:UIView) {
        if view.layer.speed == 0.0 { return }
        let pausedTime = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        view.layer.speed = 0.0
        view.layer.timeOffset = pausedTime
    }
    
    /**
     Resume Animation For View
     
     - parameter view: View
     */
    internal class func resumeAnimation(animationView view:UIView) {
        if view.layer.speed != 0.0 { return }
        let pausedTime = view.layer.timeOffset
        view.layer.speed = 1.0
        view.layer.timeOffset = 0.0
        view.layer.beginTime = 0.0
        let timeSincePause = view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        view.layer.beginTime = timeSincePause
    }
    
    /**
     Remove All Animation From View
     
     - parameter view: View
     */
    internal class func removeAllAnimation(animationView view:UIView) {
        view.layer.removeAllAnimations()
    }
    
    /**
     Remove Animation For Key
     
     - parameter view: View
     - parameter key:  Animation Key
     */
    internal class func removeAnimationForKey(animationView view:UIView, key: String) {
        view.layer.removeAnimation(forKey: key)
    }
}
