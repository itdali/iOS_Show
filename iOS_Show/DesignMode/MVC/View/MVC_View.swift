//
//  MVC_View.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class MVC_View: UIView {
    var usernameLabel: UILabel!
    var passwordLabel: UILabel!
    var phonenumLabel: UILabel!
    var emailLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label_W: CGFloat = 200
        let label_H: CGFloat = 20
        
        
        usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: label_W, height: label_H))
        usernameLabel.textColor = UIColor.blue
        self.addSubview(usernameLabel)
        
        passwordLabel = UILabel(frame: CGRect(x: 0, y: usernameLabel.frame.maxY+10, width: label_W, height: label_H))
        passwordLabel.textColor = UIColor.red
        self.addSubview(passwordLabel)
        
        phonenumLabel = UILabel(frame: CGRect(x: 0, y: passwordLabel.frame.maxY+10, width: label_W, height: label_H))
        phonenumLabel.textColor = UIColor.orange
        self.addSubview(phonenumLabel)
        
        emailLabel = UILabel(frame: CGRect(x: 0, y: phonenumLabel.frame.maxY+10, width: label_W, height: label_H))
        emailLabel.textColor = UIColor.green
        self.addSubview(emailLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
