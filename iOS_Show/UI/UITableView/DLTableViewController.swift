//
//  DLTableViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/19.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let cellID = "tableCellID"
    var dataArray: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataSource()
        loadAllUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func loadDataSource() {
        dataArray.removeAllObjects()
        let dicArray:NSMutableArray = NSMutableArray(contentsOfFile: Bundle.main.path(forResource: "TableViewData", ofType: "plist")!)!
        for i in 0..<dicArray.count {
            let model = DLTableViewModel()
            model.mj_setKeyValues(dicArray[i])
            dataArray.add(model)
        }
        DLprint(dataArray)
    }
    
    func loadAllUI () {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(UINib(nibName: "DLTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        //tableView.register(MyCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(DLTableViewController.headerClick))
        tableView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(DLTableViewController.footerClick))
        tableView.mj_footer = footer
        
        let rightButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(DLTableViewController.editButtonClick(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
        // tableView 的一些小细节
        tableView.showsVerticalScrollIndicator = true
    }
    
    
    //MARK: MJRefresh
    func headerClick () {
        Thread.sleep(forTimeInterval: 2)
        tableView.mj_header.endRefreshing()
    }
    func footerClick () {
        Thread.sleep(forTimeInterval: 2)
        tableView.mj_footer.endRefreshing()
    }
    
    
    //MARK: Table View Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DLTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DLTableViewCell
        let model: DLTableViewModel = dataArray[(indexPath as NSIndexPath).row] as! DLTableViewModel
        DLprint(model.image)
        cell.imageView?.image = UIImage(named: model.image)
        cell.cellTitle.text = model.title + String((indexPath as NSIndexPath).row)
        cell.cellText.text = model.text
        cell.cellDate.text = model.date
        
        
        cell.selectionStyle = .none
        
        
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID)!
//        cell.textLabel?.text = "这是第\(indexPath.row)个cell"
//        cell.detailTextLabel?.text = "副标题"
        
        //let cell: MyCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MyCell
        
        return cell
    }
    
    //MARK: Table View Delegate
    // tableView的样式设置，包括Header和footer的标题、高度、自定义view，cell高度
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header-\(section)"
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "footer-\(section)"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.orange
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.blue
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 30
    }
    // 选中cell时触发方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("选中了第\(indexPath.row)个cell")
        DLprint(dataArray[(indexPath as NSIndexPath).row])
        let cell: DLTableViewCell = tableView.cellForRow(at: indexPath) as! DLTableViewCell
        self.performSegue(withIdentifier: "tableToDetail", sender: cell.cellTitle.text)
    }
    // 跳转时传值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC:DLTableViewDetail = segue.destination as! DLTableViewDetail
        detailVC.detailTitle = sender as! String
    }
    
    //MARK: cell移动相关
    // 设置 cell 是否允许移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 移动 cell 完成时触发
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataArray.exchangeObject(at: (sourceIndexPath as NSIndexPath).row, withObjectAt: (destinationIndexPath as NSIndexPath).row)
    }
    // 开启/关闭移动状态
    func editButtonClick(_ buttonItem: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        buttonItem.title = (tableView.isEditing ? "Done" : "Edit")
        DLprint(dataArray)
    }
    
    //MARK: cell左滑相关
    // 设置 cell 是否允许左滑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /*  下面两个是默认的左滑按钮*/
    // 设置默认的左滑按钮的title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "按钮钮钮"
    }
    // 点击左滑出现的按钮时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DLprint("点击左滑出现的按钮时触发")
        return
    }
 
    
    // 左滑结束时调用
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        DLprint("")
    }
    
    // 自定义左滑cell时的按钮和触发方法
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cellActionA = UITableViewRowAction(style: .default, title: "按钮-1", handler: {_,_ in
            DLprint("点击了 按钮-1")
        })
        cellActionA.backgroundColor = UIColor.green
        
        let cellActionB = UITableViewRowAction(style: .default, title: "按钮-2", handler: {_,_ in
            DLprint("点击了 按钮-2")
        })
        return [cellActionA, cellActionB]
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
