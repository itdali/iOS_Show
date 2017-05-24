//
//  TransitionAnimationVC.swift
//  iOS_Show
//
//  Created by dali on 16/11/1.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class TransitionAnimationVC: UIViewController,UIViewControllerTransitioningDelegate {

    var coverVerticalBtn: UIButton!
    var flipHorizontalBtn: UIButton!
    var crossDissolveBtn: UIButton!
    var partialCurlBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        loadAllUI()
    }

    func loadAllUI() {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Transition Animation"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(titleLabel)
        
        let backBtn: UIButton = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        view.addSubview(backBtn)
    
        coverVerticalBtn = UIButton()
        coverVerticalBtn.setTitle("coverVertical", for: .normal)
        coverVerticalBtn.setTitleColor(UIColor.blue, for: .normal)
        coverVerticalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        coverVerticalBtn.addTarget(self, action: #selector(transitionPage), for: UIControlEvents.touchUpInside)
        view.addSubview(coverVerticalBtn)
        
        flipHorizontalBtn = UIButton()
        flipHorizontalBtn.setTitle("FlipHorizontal", for: .normal)
        flipHorizontalBtn.setTitleColor(UIColor.blue, for: .normal)
        flipHorizontalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        flipHorizontalBtn.addTarget(self, action: #selector(transitionPage), for: UIControlEvents.touchUpInside)
        view.addSubview(flipHorizontalBtn)
        
        crossDissolveBtn = UIButton()
        crossDissolveBtn.setTitle("crossDissolve", for: .normal)
        crossDissolveBtn.setTitleColor(UIColor.blue, for: .normal)
        crossDissolveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        crossDissolveBtn.addTarget(self, action: #selector(transitionPage), for: UIControlEvents.touchUpInside)
        view.addSubview(crossDissolveBtn)
        
        partialCurlBtn = UIButton()
        partialCurlBtn.setTitle("partialCurl", for: .normal)
        partialCurlBtn.setTitleColor(UIColor.blue, for: .normal)
        partialCurlBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        partialCurlBtn.addTarget(self, action: #selector(transitionPage), for: UIControlEvents.touchUpInside)
        view.addSubview(partialCurlBtn)
        
        titleLabel.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 200, height: 20))
            make.top.equalTo(view).offset(20)
            make.centerX.equalTo(view)
        }
        backBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.top.left.equalTo(view).offset(20)
        }
        coverVerticalBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 120, height: 30))
            make.top.equalTo(backBtn.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
        }
        flipHorizontalBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(coverVerticalBtn)
            make.centerX.equalTo(coverVerticalBtn)
            make.centerY.equalTo(coverVerticalBtn).offset(40)
        }
        crossDissolveBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(flipHorizontalBtn)
            make.centerX.equalTo(flipHorizontalBtn)
            make.centerY.equalTo(flipHorizontalBtn).offset(40)
        }
        partialCurlBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(crossDissolveBtn)
            make.centerX.equalTo(crossDissolveBtn)
            make.centerY.equalTo(crossDissolveBtn).offset(40)
        }
    }
    
    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func transitionPage(sender: UIButton) {
        let firstVC = TransitionFirstVC()
        
        switch sender {
        case coverVerticalBtn:
            firstVC.modalTransitionStyle = .coverVertical
        case flipHorizontalBtn:
            firstVC.modalTransitionStyle = .flipHorizontal
        case crossDissolveBtn:
            firstVC.modalTransitionStyle = .crossDissolve
        case partialCurlBtn:
            firstVC.modalTransitionStyle = .partialCurl
        default:
            firstVC.modalTransitionStyle = .coverVertical
        }
        
        self.present(firstVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
