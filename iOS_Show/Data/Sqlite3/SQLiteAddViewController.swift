//
//  SQLiteAddViewController.swift
//  iOS_Show
//
//  Created by dali on 2016/12/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class SQLiteAddViewController: UIViewController {
    
    var name_field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        loadAllUI()
    }

    func loadAllUI() {
        name_field = UITextField()
        name_field.layer.borderWidth = 0.5
        name_field.layer.borderColor = UIColor.lightGray.cgColor
        name_field.layer.cornerRadius = 5
        name_field.clipsToBounds = true
        view.addSubview(name_field)
        
        let addBtn: UIButton = UIButton()
        addBtn.setTitle("增加", for: .normal)
        addBtn.setTitleColor(UIColor.blue, for: .normal)
        addBtn.backgroundColor = SystemBlue
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addBtn.addTarget(self, action: #selector(addClick), for: UIControlEvents.touchUpInside)
        view.addSubview(addBtn)
        
        name_field.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 200, height: 40))
            make.centerX.equalTo(view)
            make.centerY.equalTo(view.snp.top).offset(100)
        }
        
        addBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(name_field)
            make.centerX.equalTo(name_field)
            make.centerY.equalTo(name_field.snp.bottom).offset(50)
        }
        
    }
    
    // 插入数据
    func addClick() {
        DLprint("")
        guard !name_field.text!.isEmpty else {
            DLprint("数据为空，不可插入")
            return
        }
        let insertSQL = "insert into t_person (pName) values ('\(name_field.text!)');"
        if SQLiteManager.shareInstance().exec(SQL: insertSQL) == true{
            DLprint("插入成功")
        } else {
            DLprint("插入失败")
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
