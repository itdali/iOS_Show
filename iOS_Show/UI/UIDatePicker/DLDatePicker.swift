//
//  DLDatePicker.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLDatePicker: UIViewController {
    
    var datePickerA: UIDatePicker!
    var datePickerB: UIDatePicker!
    var datePickerC: UIDatePicker!
    var datePickerD: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDatePicker()
    }

    func loadDatePicker() {
        datePickerA = UIDatePicker(frame: CGRect(x: 0, y: 70, width: 300, height: 120))
        datePickerA.backgroundColor = UIColor.orange
        datePickerA.datePickerMode = .date
        datePickerA.addTarget(self, action: #selector(DLDatePicker.datePickerClick(_:)), for: .valueChanged)
        self.view.addSubview(datePickerA)
        
        datePickerB = UIDatePicker(frame: CGRect(x: 0, y: datePickerA.frame.maxY+20, width: 300, height: 120))
        datePickerB.backgroundColor = UIColor.orange
        datePickerB.datePickerMode = .time
        datePickerB.addTarget(self, action: #selector(DLDatePicker.datePickerClick(_:)), for: .valueChanged)
        self.view.addSubview(datePickerB)
        
        datePickerC = UIDatePicker(frame: CGRect(x: 0, y: datePickerB.frame.maxY+20, width: 300, height: 120))
        datePickerC.backgroundColor = UIColor.orange
        datePickerC.datePickerMode = .dateAndTime
        datePickerC.addTarget(self, action: #selector(DLDatePicker.datePickerClick(_:)), for: .valueChanged)
        self.view.addSubview(datePickerC)
        
        datePickerD = UIDatePicker(frame: CGRect(x: 0, y: datePickerC.frame.maxY+20, width: 300, height: 120))
        datePickerD.backgroundColor = UIColor.orange
        datePickerD.datePickerMode = .countDownTimer
        datePickerD.addTarget(self, action: #selector(DLDatePicker.datePickerClick(_:)), for: .valueChanged)
        self.view.addSubview(datePickerD)
        
    }
    
    func datePickerClick(_ datePicker: UIDatePicker) {
        DLprint(datePickerA.date)
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
