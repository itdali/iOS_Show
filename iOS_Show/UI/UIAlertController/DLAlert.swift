//
//  DLAlert.swift
//  iOS_Show
//
//  Created by dali on 16/10/31.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

private let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width  //屏幕宽度
private let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height

class DLAlert: UIViewController {
    
    var alertView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var subTitleTextView: UITextView = UITextView()
    var buttons: [UIButton] = []
    var strongSelf:DLAlert?
    var userActionL:(() -> Void)? = nil
    var userActionR:(() -> Void)? = nil

    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.main.bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        //强引用 不然按钮点击不能执行
        strongSelf = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 初始化
    fileprivate func setupAlertView() {
        
        alertView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        alertView.layer.cornerRadius = 10.0
        alertView.layer.masksToBounds = true
        alertView.layer.borderWidth = 0.5
        view.addSubview(alertView)
        
        // Title
        titleLabel.text = ""
        titleLabel.textColor = UIColor(white: 0.1, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        // Subtitle
        subTitleTextView.text = ""
        subTitleTextView.textAlignment = .center
        subTitleTextView.backgroundColor = UIColor.clear
        subTitleTextView.font = UIFont(name: "Helvetica", size:14)
        subTitleTextView.textColor = UIColor(white: 0.2, alpha: 1.0)
        subTitleTextView.isEditable = false
        alertView.addSubview(subTitleTextView)
        
        //titleLabel.backgroundColor = UIColor.orange
        //subTitleTextView.backgroundColor = UIColor.brown
    }
    
    //MARK:- 更新Layout
    fileprivate func updateLayout() {
        alertView.frame = CGRect(x: 50, y: 200, width: (SCREEN_WIDTH-100), height: (SCREEN_HEIGHT-200)*0.5)
        
        let x: CGFloat = 20
        let padding: CGFloat = 10
        let width: CGFloat = alertView.frame.width-x*2
        titleLabel.frame = CGRect(x: x, y: 20, width: width, height: 20)
        
        if self.subTitleTextView.text.isEmpty == false {
            let subtitleString = subTitleTextView.text! as NSString
            let rect = subtitleString.boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:subTitleTextView.font!], context: nil)
            let textViewHeight = ceil(rect.size.height) + padding
            subTitleTextView.frame = CGRect(x: x, y: titleLabel.frame.maxY+2, width: width, height: textViewHeight)
        }
        let cancleBtn = buttons[0]
        if buttons.count == 1 {
            cancleBtn.frame = CGRect(x: -1, y: subTitleTextView.frame.maxY+padding, width: alertView.frame.width+2, height: 45)
            alertView.addSubview(cancleBtn)
        } else if buttons.count == 2 {
            cancleBtn.frame = CGRect(x: -1, y: subTitleTextView.frame.maxY+padding, width: alertView.frame.width*0.5+1, height: 45)
            alertView.addSubview(cancleBtn)
            let confirmBtn = buttons[1]
            confirmBtn.frame = CGRect(x: alertView.frame.width*0.5-0.5, y: cancleBtn.frame.minY, width: alertView.frame.width*0.5+1, height: 45)
            alertView.addSubview(confirmBtn)
        }
        
        let alertH: CGFloat = cancleBtn.frame.maxY - 1
        alertView.frame.size.height = alertH
        alertView.frame.origin.y = (SCREEN_HEIGHT-alertH)*0.5
    }
    
    //MARK:- 主方法
    func showAlert(_ title: String, subTitle: String?,cancleBtnTitle: String,actionL:@escaping (() -> Void),confirmBtnTitle:String?,actionR:@escaping (() -> Void)) {
        userActionL = actionL
        userActionR = actionR
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubview(toFront: view)
        view.frame = window.bounds
        
        // 初始化
        self.setupAlertView()
        
        titleLabel.text = title
        if subTitle != nil {
            subTitleTextView.text = subTitle
            if ((subTitle?.range(of:"\n")) != nil || (subTitle?.range(of:"\t")) != nil) { subTitleTextView.textAlignment = .left}
        }
        buttons = []
        if cancleBtnTitle.isEmpty == false {
            let button: UIButton = UIButton()
            button.setTitle(cancleBtnTitle, for: UIControlState())
            button.setTitleColor(UIColor(red: 0.08, green: 0.49, blue: 0.98, alpha: 1.0), for: UIControlState())
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
            //button.backgroundColor = UIColor.darkGray
            button.isUserInteractionEnabled = true
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.addTarget(self, action: #selector(DLAlert.actionLClick), for: UIControlEvents.touchUpInside)
            button.tag = 0
            buttons.append(button)
        }
        
        if confirmBtnTitle != nil && confirmBtnTitle!.isEmpty == false {
            let button: UIButton = UIButton(type: UIButtonType.custom)
            button.setTitle(confirmBtnTitle, for: UIControlState())
            button.setTitleColor(UIColor(red: 0.08, green: 0.49, blue: 0.98, alpha: 1.0), for: UIControlState())
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
            //button.backgroundColor = UIColor.blue
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.addTarget(self, action: #selector(DLAlert.pressed), for: UIControlEvents.touchUpInside)
            
            button.tag = 1
            buttons.append(button)
        }
        updateLayout()
    }
    
    // 左按钮
    func actionLClick() {
        if userActionL !=  nil {
            userActionL!()
            doCancel()
        }
    }
    
    // 取消按钮
    func doCancel(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
            //self.alertView.transform = CGAffineTransform(translationX: 0, y: SCREEN_HEIGHT)
        }) { (Bool) -> Void in
            self.view.removeFromSuperview()
            self.cleanUpAlert()
            self.strongSelf = nil
        }
    }
    
    fileprivate func cleanUpAlert() {
        self.alertView.removeFromSuperview()
        self.alertView = UIView()
    }
    
    // 确认按钮
    func pressed() {
        if userActionR !=  nil {
            userActionR!()
            doCancel()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
