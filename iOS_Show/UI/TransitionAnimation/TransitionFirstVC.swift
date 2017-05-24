//
//  TransitionFirstVC.swift
//  iOS_Show
//
//  Created by dali on 16/11/1.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class TransitionFirstVC: UIViewController,UIViewControllerTransitioningDelegate {
    
    lazy var secondVC: TransitionSecondVC = TransitionSecondVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange

        loadAllUI()
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.transitioningDelegate = self
    }
    
    func loadAllUI() {
        let backBtn: UIButton = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        view.addSubview(backBtn)
        
        let transitionBtn: UIButton = UIButton()
        transitionBtn.setTitle("淡入淡出", for: .normal)
        transitionBtn.setTitleColor(UIColor.blue, for: .normal)
        transitionBtn.addTarget(self, action: #selector(transitionClick), for: UIControlEvents.touchUpInside)
        view.addSubview(transitionBtn)
        
        
        
        backBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.top.left.equalTo(view).offset(20)
        }
        transitionBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 80, height: 30))
            make.top.equalTo(backBtn.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
    }
    
    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    func transitionClick() {
        self.present(secondVC, animated: true, completion: nil)
    }
    
    
    //MARK:- UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DLTransitionAnimation(transitionType: .Present, animationType: .CrossDissolve)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DLTransitionAnimation(transitionType: .Dismiss, animationType: .SpringUpDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
