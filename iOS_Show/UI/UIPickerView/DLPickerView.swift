//
//  DLPickerView.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLPickerView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView: UIPickerView!
    let dataArray: NSArray = [UIColor.orange, UIColor.green, UIColor.red, UIColor.blue, UIColor.purple, UIColor.brown, UIColor.darkGray, UIColor.magenta, UIColor.yellow]
    
    var randomButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPickerView()
    }
    
    func loadPickerView() {
        let pickerW: CGFloat = 300
        let pickerH: CGFloat = 200
        let pickerX: CGFloat = (self.view.frame.width - pickerW) * 0.5
        let pickerY: CGFloat = 150
        
        pickerView = UIPickerView(frame: CGRect(x: pickerX, y: pickerY, width: pickerW, height: pickerH))
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        
        // 随机按钮
        randomButton = UIButton(frame: CGRect(x: 20, y: 400, width: 100, height: 40))
        randomButton.setTitle("随机选择", for: UIControlState())
        randomButton.setTitleColor(UIColor.blue, for: UIControlState())
        randomButton.addTarget(self, action: #selector(DLPickerView.randomButtonClick), for: .touchUpInside)
        self.view.addSubview(randomButton)
        
    }
    
    func randomButtonClick() {
        for i in 0...2 {
            let randomNum = arc4random() % UInt32(dataArray.count)
            pickerView.selectRow(Int(randomNum), inComponent: i, animated: true)
        }
    }
    
    
    //MARK: picker view datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    
    //MARK: picker view delegate
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    /*
    // 普通的文本样式
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "abc"
    }

    // NSAttributedString样式
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let attributedStr = NSAttributedString(string: "abcde")
        return attributedStr
    }
    */
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if view == nil {
            let rowView = UIView()
            rowView.backgroundColor = dataArray[row] as? UIColor
            return rowView
        }
        else {
           return view!
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemA = pickerView.selectedRow(inComponent: 0)
        let itemB = pickerView.selectedRow(inComponent: 1)
        let itemC = pickerView.selectedRow(inComponent: 2)
        DLprint("当前选中：(0,\(itemA));(1,\(itemB));(2,\(itemC))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
