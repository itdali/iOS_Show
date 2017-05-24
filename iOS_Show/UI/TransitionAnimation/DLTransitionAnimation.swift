//
//  DLTransitionAnimation.swift
//  iOS_Show
//
//  Created by dali on 16/11/1.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

/**
 转场类型
 - Present:
 - Dismiss:
 */
public enum DLTransitionType: Int {
    case Present = 0
    case Dismiss
}

/**
 转场动画类型
 - SpringUpDown: 弹簧 - 上下弹
 - CrossDissolve: 淡入淡出
 */
public enum DLTransitionAnimationType: Int {
    case SpringUpDown = 0
    case CrossDissolve
}

class DLTransitionAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    private var transtType = DLTransitionType.Present
    private var animtType = DLTransitionAnimationType.SpringUpDown
    
    init(transitionType:DLTransitionType, animationType: DLTransitionAnimationType) {
        super.init()
        transtType = transitionType
        animtType = animationType
    }
    /// 设置动画的持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    /// 设置动画的进行方式，附有详细注释，demo中其他地方的这个方法不再解释
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch animtType {
        case .SpringUpDown:
            springUpDown(using: transitionContext)
        case .CrossDissolve:
            crossDissolve(using: transitionContext)
        }
    }
    
    /**
     转场动画类型: 弹簧 - 上下弹
     */
    func springUpDown(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        // 需要关注一下from/to和presented/presenting的关系
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        var fromView: UIView!
        var toView: UIView!
        if transtType == .Present {
            fromView = fromViewController?.view
            toView = toViewController?.view
        } else {
            fromView = toViewController?.view
            toView = fromViewController?.view
        }
        
        
        // iOS8引入了viewForKey方法，尽可能使用这个方法而不是直接访问controller的view属性
        // 比如在form sheet样式中，我们为presentedViewController的view添加阴影或其他decoration，animator会对整个decoration view
        // 添加动画效果，而此时presentedViewController的view只是decoration view的一个子视图
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        }
        
        // 我们让toview的origin.y在屏幕的一半处，这样它从屏幕的中间位置弹起而不是从屏幕底部弹起，弹起过程中逐渐变为不透明
        toView?.frame = CGRect(x: fromView!.frame.origin.x, y: fromView!.frame.maxY / 2, width: fromView!.frame.width, height: fromView!.frame.height)
        toView?.alpha = 0.0
        
        // 在present和，dismiss时，必须将toview添加到视图层次中
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        // 使用spring动画，有弹簧效果，动画结束后一定要调用completeTransition方法
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: { () -> Void in
            toView!.alpha = 1.0     // 逐渐变为不透明
            toView?.frame = transitionContext.finalFrame(for: toViewController!)    // 移动到指定位置
        }) { (finished: Bool) -> Void in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
    /**
     转场动画类型: 淡入淡出
     */
    func crossDissolve(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        var fromView = fromViewController?.view
        var toView = toViewController?.view
        
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        }
        
        fromView?.frame = transitionContext.initialFrame(for: fromViewController!)
        toView?.frame = transitionContext.finalFrame(for: toViewController!)
        
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView!.alpha = 0.0
            toView!.alpha = 1.0
            }, completion: { (finished: Bool) -> Void in
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
        })
    }
}
