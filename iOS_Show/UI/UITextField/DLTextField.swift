//
//  DLTextField.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLTextField: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var textFieldA: UITextField!
    @IBOutlet weak var textFieldB: UITextField!
    @IBOutlet weak var textFieldC: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldConfig()
    }
    
    func textFieldConfig() {
        textFieldA.placeholder = "第一个输入框"
        textFieldA.delegate = self
        // 自定义键盘回车键
        textFieldA.returnKeyType = .join
        
        
        let leftLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: 30, height: 30))
        leftLabel.text = "左侧"
        leftLabel.textColor = UIColor.white
        leftLabel.font = UIFont.systemFont(ofSize: 12)
        leftLabel.backgroundColor = UIColor.orange
        textFieldB.leftView = leftLabel
        textFieldB.leftViewMode = .always
        textFieldB.placeholder = "第二个输入框"
        textFieldB.keyboardType = .numberPad
        textFieldB.textColor = UIColor.red
        // 右侧的清除按钮
        textFieldB.clearButtonMode = .whileEditing
        // 自动大写
        textFieldB.autocapitalizationType = .none
        // 自动更正
        textFieldB.autocorrectionType = .no
        // 拼写检查
        textFieldB.spellCheckingType = .no
        // 文本改为密码样式的星号
        textFieldB.isSecureTextEntry = true
        
        
        let rightLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: 30, height: 30))
        rightLabel.text = "右侧"
        rightLabel.textColor = UIColor.lightGray
        rightLabel.font = UIFont.systemFont(ofSize: 12)
        rightLabel.backgroundColor = UIColor.darkGray
        textFieldC.rightView = rightLabel
        textFieldC.rightViewMode = .always
        textFieldC.placeholder = "第三个输入框"
        textFieldC.keyboardType = .emailAddress
        textFieldC.addTarget(self, action: #selector(DLTextField.textFieldChanged(_:)), for: .valueChanged)
    }
    
    // 内容改变时调用
    func textFieldChanged(_ textField: UITextField) {
        DLprint(textField.text)
    }
    
    //MARK:  textField delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    // 自定义回车键
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DLprint("自定义回车键")
        return true
    }
    
    
    
    // 点击空白处收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
