//
//  SQLiteViewController.swift
//  iOS_Show
//
//  Created by dali on 2016/12/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class SQLiteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tbView: UITableView!
    let cellID: String = "sqliteCellID"
    var dataArray: Array<SQLiteModal> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // 加载数据
    func loadData() {
        let querySQL = "SELECT id,pName FROM 't_person'"
        var resultDataArr = SQLiteManager.shareInstance().queryDataBase(SQL: querySQL)
        dataArray = []
        if resultDataArr == nil {
            resultDataArr = []
            DLprint("表内暂无数据")
        } else {
            for dict in resultDataArr! {
                DLprint(dict)
                let modal = SQLiteModal(id: Int(dict["id"] as! String)!, name: dict["pName"] as! String)
                dataArray.append(modal)
                tbView.reloadData()
            }
        }
    }
    
    // 加载页面控件
    func loadAllUI() {
        tbView = UITableView()
        tbView.delegate = self
        tbView.dataSource = self
        tbView.tableFooterView = UIView()
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.addSubview(tbView)
        
        
        tbView.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(view)
            make.center.equalTo(view)
        }
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addClick))
        //let addBtn = UIBarButtonItem(title: "增加", style: .plain, target: self, action: #selector(addClick))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    // 增加数据
    func addClick() {
        let addVC = SQLiteAddViewController()
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    //MARK:- table view dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.selectionStyle = .none
        let modal: SQLiteModal = dataArray[indexPath.row]
        cell.textLabel?.text = modal.name
        return cell
    }
    //MARK:- table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC: SQLiteDetailViewController = SQLiteDetailViewController()
        detailVC.dataModal = dataArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    //MARK: cell左滑相关
    // 设置 cell 是否允许左滑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /*  下面两个是默认的左滑按钮*/
    // 设置默认的左滑按钮的title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    // 点击左滑出现的按钮时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DLprint("点击左滑出现的按钮时触发")
        let modal: SQLiteModal = dataArray[indexPath.row]
        let updateSQL = "delete from t_person where id = \(modal.id);"
        if SQLiteManager.shareInstance().exec(SQL: updateSQL) == true{
            DLprint("修改成功")
        } else {
            DLprint("修改失败")
        }
        loadData()
        return
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
