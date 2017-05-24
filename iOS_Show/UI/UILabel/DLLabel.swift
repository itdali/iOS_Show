//
//  DLLabel.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/26.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLLabel: UIViewController {
    
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var labelE: UILabel!
    @IBOutlet weak var labelF: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        labelConfig()
    }
    
    func labelConfig() {
        labelA.text = "我是LabelA, 我是LabelA"
        labelA.textAlignment = .left
        labelA.textColor = UIColor.red
        labelA.backgroundColor = UIColor.lightGray
        labelA.font = UIFont.systemFont(ofSize: 16)
        labelA.numberOfLines = 0
        labelA.shadowColor = UIColor.darkGray
        labelA.shadowOffset = CGSize(width: 5, height: 5)
        
        
        
        labelB.text = "我是LabelB, 我是LabelB"
        labelB.textAlignment = .center
        labelB.textColor = UIColor.green
        labelB.backgroundColor = UIColor.lightGray
        labelB.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin)
        labelB.numberOfLines = 0
        //labelB.shadowColor = UIColor.darkGrayColor()
        //labelB.shadowOffset = CGSizeMake(1, 1)
        
        
        
        labelC.text = "我是LabelC, 我是LabelC"
        labelC.textAlignment = .right
        labelC.textColor = UIColor.orange
        labelC.backgroundColor = UIColor.lightGray
        labelC.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightUltraLight)
        labelC.numberOfLines = 0
        //labelC.shadowColor = UIColor.darkGrayColor()
        //labelC.shadowOffset = CGSizeMake(1, 1)
        
        
        
        labelD.text = "我是LabelD, 我是LabelD"
        labelD.textAlignment = .justified
        labelD.textColor = UIColor.blue
        labelD.backgroundColor = UIColor.lightGray
        labelD.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        labelD.numberOfLines = 0
        //labelD.shadowColor = UIColor.darkGrayColor()
        //labelD.shadowOffset = CGSizeMake(1, 1)
        
        
        
        labelE.text = "我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE, 我是LabelE"
        labelE.textAlignment = .natural
        labelE.textColor = UIColor.purple
        //labelE.backgroundColor = UIColor.lightGrayColor()
        labelE.font = UIFont.systemFont(ofSize: 16)
        labelE.numberOfLines = 0
        //labelE.shadowColor = UIColor.darkGrayColor()
        //labelE.shadowOffset = CGSizeMake(1, 1)
        
        
        
        let labelFText = "我是LabelF,我是LabelF,我是LabelF"
        let rangeA = NSRange.init(location: 0, length: 9)
        let rangeB = NSRange.init(location: 9, length: 9)
        let rangeC = NSRange.init(location: 18, length: 8)
        let attributedStr = NSMutableAttributedString(string: labelFText)
        
        // 添加颜色
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: rangeA)
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: rangeB)
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: rangeC)
        
        // 添加字体
        attributedStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Arial-BoldItalicMT", size: 18)!, range: rangeA)
        attributedStr.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 18)!, range: rangeB)
        attributedStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Arial-BoldItalicMT", size: 18)!, range: rangeC)
        
        labelF.attributedText = attributedStr
        //labelF.textAlignment = .Natural
        //labelF.textColor = UIColor.brownColor()
        //labelF.backgroundColor = UIColor.lightGrayColor()
        //labelF.font = UIFont.systemFontOfSize(18, weight: UIFontWeightSemibold)
        //labelF.numberOfLines = 0
        //labelF.shadowColor = UIColor.darkGrayColor()
        //labelF.shadowOffset = CGSizeMake(1, 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
