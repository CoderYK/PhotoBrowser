//
//  AnimateManager.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

class AnimateManager: NSObject {
    
    var isPresented : Bool = false
    
}


// MARK:- 实现browserVc的转场代理方法
extension AnimateManager : UIViewControllerTransitioningDelegate {
    
    // 告诉系统转场动画由谁去管理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        
        return self
    }
    
    // 告诉系统消失的动画交给谁去管理
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = false
        
        return self
    }
}

// MARK:- 实现转场动画
extension AnimateManager : UIViewControllerAnimatedTransitioning {
    
    // 1.决定动画执行时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    // 2.决定动画如何实现
    // transitionContext: 可以通过转场上下文来获取弹出的 View 和消失的 View
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresented {
            
            // 1.获取弹出的 View
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            // 2.将弹出的 View 添加到 containerView 中
            transitionContext.containerView()?.addSubview(presentView)
            
            // 3.执行动画
            presentView.alpha = 0.0
            let duration = transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, animations: {
                presentView.alpha = 1.0
            }) { (_) in
                // 动画完成
                transitionContext.completeTransition(true)
            }
        } else {
            
            // 2.1.获取消失的 View
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            // 2.3.执行动画
            let duration = transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, animations: {
                dismissView?.alpha = 0.0
            }) { (_) in
                // 将消失的 View 从containerView中移除
                dismissView?.removeFromSuperview()
                // 动画完成
                transitionContext.completeTransition(true)
            }
        }
    }
}

/*
 自定义转场动画
 1.成为转场动画代理 UIViewControllerTransitioningDelegate
    1.1.决定转场动画交给谁去管理
 2.实现转场动画
    2.1.决定动画的执行时间
    2.2.获得弹出/消失的 View
    2.3.弹出:将弹出 View 添加到 containerView 中  消失:执行动画后把 View 移除
        (modal : 先把 modal 前的 View 从容器 View 中移除,然后把 modal 出来的 View 添加到容器 View 上)
    2.4.动画完成时告诉转场上下文,转场完成
 */
