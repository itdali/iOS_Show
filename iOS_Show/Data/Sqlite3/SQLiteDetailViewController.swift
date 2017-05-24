//
//  SQLiteDetailViewController.swift
//  iOS_Show
//
//  Created by dali on 2016/12/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class SQLiteDetailViewController: UIViewController {
    
    var dataModal: SQLiteModal!
    var name_field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        DLprint("sqLiteModal.name==\(dataModal.name)")
        
        loadAllUI()
        name_field.text = dataModal.name

    }
    
    func loadAllUI() {
        name_field = UITextField()
        name_field.layer.borderWidth = 0.5
        name_field.layer.borderColor = UIColor.lightGray.cgColor
        name_field.layer.cornerRadius = 5
        name_field.clipsToBounds = true
        view.addSubview(name_field)
        
        let updateBtn: UIButton = UIButton()
        updateBtn.setTitle("修改", for: .normal)
        updateBtn.setTitleColor(UIColor.blue, for: .normal)
        updateBtn.backgroundColor = SystemBlue
        updateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        updateBtn.addTarget(self, action: #selector(updateClick), for: UIControlEvents.touchUpInside)
        view.addSubview(updateBtn)
        
        name_field.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 200, height: 40))
            make.centerX.equalTo(view)
            make.centerY.equalTo(view.snp.top).offset(100)
        }
        
        updateBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(name_field)
            make.centerX.equalTo(name_field)
            make.centerY.equalTo(name_field.snp.bottom).offset(50)
        }
        
    }
    
    func updateClick() {
        DLprint("")
        guard !name_field.text!.isEmpty else {
            DLprint("数据为空，不可修改")
            return
        }
        let updateSQL = "update t_person set pName = '\(name_field.text!)' where id = \(dataModal.id);"
        if SQLiteManager.shareInstance().exec(SQL: updateSQL) == true{
            DLprint("修改成功")
        } else {
            DLprint("修改失败")
        }
        _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
