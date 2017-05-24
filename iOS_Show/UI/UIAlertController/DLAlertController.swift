//
//  DLAlertController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLAlertController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK:- UIAlert Controller
    @IBAction func alertControllerA() {
        // 创建一个UIAlertController，命名为alertOne
        let alertA = UIAlertController.init(title: "Alert-1", message: "普通的Alert", preferredStyle: UIAlertControllerStyle.alert)
        // 创建一个“取消”按钮
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        // 创建一个“确定”按钮
        let confirmAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default){ (action: UIAlertAction) -> Void in
            // 在此写点击“确定”按钮的触发事件
            // ......
        }
        // 将两个按钮添加到alertOne
        alertA.addAction(cancelAction)
        alertA.addAction(confirmAction)
        
        // 弹出alertOne
        self.present(alertA, animated: true, completion: nil)
    }
    
    @IBAction func alertControllerB() {
        // 创建一个UIAlertController，命名为alertTwo
        let alertB = UIAlertController.init(title: "Alert-2", message: "带有输入框的Alert", preferredStyle: UIAlertControllerStyle.alert)
        // 给alertTwo添加第一个输入框
        alertB.addTextField{ (textfield: UITextField) -> Void in
            textfield.placeholder = "第一个输入框"
        }
        // 给alertTwo添加第二个输入框
        alertB.addTextField{ (textfield: UITextField) -> Void in
            textfield.placeholder = "第二个输入框"
        }
        // 创建一个“取消”按钮
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        // 创建一个“确定”按钮
        let confirmAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default){ (action: UIAlertAction) -> Void in
            // 在此写点击“确定”按钮的触发事件
            // ......
            print(alertB.textFields![0].text!)
            print(alertB.textFields![1].text!)
        }
        // 将两个按钮添加到alertTwo
        alertB.addAction(cancelAction)
        alertB.addAction(confirmAction)
        
        // 弹出alertTwo
        self.present(alertB, animated: true, completion: nil)
    }
    
    @IBAction func alertControllerC() {
        // 创建一个UIAlertController, 命名为alertThree, preferredStyle 设置为 ActionSheet
        let alertC = UIAlertController.init(title: "ActionSheet - 1", message: "这是一个ActionSheet", preferredStyle: UIAlertControllerStyle.actionSheet)
        // 创建一个“取消”按钮
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        // 创建一个“确定”按钮
        let confirmAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default){ (action: UIAlertAction) -> Void in
            // 在此写点击“确定”按钮的触发事件
            // ......
        }
        // 将两个按钮添加到alertTwo
        alertC.addAction(cancelAction)
        alertC.addAction(confirmAction)
        
        // 弹出alertThree
        self.present(alertC, animated: true, completion: nil)
    }
    
    //MARK:- DLAlert
    @IBAction func dlAlert() {
        /*
        DLAlert().showAlert("标题", subTitle: "\t1.内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内\n\t容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容", cancleBtnTitle: "取消", confirmBtnTitle: "confirm"){(button) -> Void in
            DLprint("")
        }*/
        
        //DLAlert().showAlert("title", subTitle: "abccccccccccccccccc\nccccccccadafefadfad", cancleBtnTitle: "cancle", actionL: {() -> Void in}, confirmBtnTitle: "confirm", actionR: {(button) -> Void in})
        
        DLAlert().showAlert("页面加载失败", subTitle: "页面加载失败", cancleBtnTitle: "返回", actionL: {() -> Void in}, confirmBtnTitle: "重试"){() -> Void in}
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
