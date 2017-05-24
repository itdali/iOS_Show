//
//  DLWKHistory.swift
//  iOS_Show
//
//  Created by dali on 23/03/2017.
//  Copyright © 2017 dali. All rights reserved.
//

import UIKit
import WebKit

public protocol DLWKHistoryDelegate: NSObjectProtocol {
    func dlWKHistoryOpenPage(with url:URL)
}

private enum DLWKHistoryClearStyle: String {
    case theLastHour = "The last hour"
    case today = "Today"
    case todayAndYesterday = "Today and yesterday"
    case allTime = "All time"
}

class DLWKHistory: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate: DLWKHistoryDelegate!
    
    private var webHistory: Array<DLWKHistoryModal> = []
    //private var webArray: Array<[String: Array<DLWKHistoryModal>]> = [[:]]
    //private var webTest: Array<[String:Array<Int>]> = [[:]]
    
    private var navBar: UINavigationBar!
    private var navItem: UINavigationItem!
    private var tableView: UITableView!
    private let cellID: String = "WKHistoryCellID"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        addNavigationBar()
        loadAllUI()
        loadData()
        
    }
    
    //MARK:- add navigation bar
    func addNavigationBar() {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: 44))
        navBar.barTintColor = self.view.backgroundColor
        navItem = UINavigationItem()
        navItem.title = "History"
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClick))
        let clearBtn = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearClick))
        navItem.setRightBarButtonItems([doneBtn, clearBtn], animated: true)
        navBar.pushItem(navItem, animated: true)
        self.view.addSubview(navBar)
    }
    func doneClick() {
        DLprint("")
        self.dismiss(animated: true, completion: nil)
    }
    func clearClick() {
        let clearAlert = UIAlertController.init(title: "Cookies, website and history data will be cleared from this iPhone. Clear from:", message: nil, preferredStyle: .actionSheet)
        let theLastHour = UIAlertAction(title: DLWKHistoryClearStyle.theLastHour.rawValue, style: .default, handler: {(action) -> Void in
            self.clearData(from: .theLastHour)
        })
        let today = UIAlertAction(title: DLWKHistoryClearStyle.today.rawValue, style: .default, handler: {(action) -> Void in
            self.clearData(from: .today)
        })
        let todayAndYestd = UIAlertAction(title: DLWKHistoryClearStyle.todayAndYesterday.rawValue, style: .default, handler: {(action) -> Void in
            self.clearData(from: .todayAndYesterday)
        })
        let allTime = UIAlertAction(title: DLWKHistoryClearStyle.allTime.rawValue, style: .default, handler: {(action) -> Void in
            self.clearData(from: .allTime)
        })
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        clearAlert.addAction(theLastHour)
        clearAlert.addAction(today)
        clearAlert.addAction(todayAndYestd)
        clearAlert.addAction(allTime)
        clearAlert.addAction(cancelBtn)
        self.present(clearAlert, animated: true, completion: nil)
    }
    private func clearData(from time: DLWKHistoryClearStyle) {
        switch time {
        case .theLastHour:
            DLprint(time.rawValue)
        case .today:
            DLprint(time.rawValue)
        case .todayAndYesterday:
            DLprint(time.rawValue)
        case .allTime:
            DLprint(time.rawValue)
        }
    }
    
    //MARK:- load ui and data
    func loadAllUI() {
        tableView = UITableView(frame: CGRect(x: 0, y: navBar.frame.maxY, width: kScreenWidth, height: kScreenHeight-navBar.frame.maxY), style: .plain)
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    func loadData() {
        let querySQL = "SELECT id,hTitle,hUrl,hDate FROM 't_webview_history' order by hDate asc"
        var resultDataArr = SQLiteManager.shareInstance().queryDataBase(SQL: querySQL)
        webHistory = []
        if resultDataArr == nil {
            resultDataArr = []
            DLprint("表内暂无数据")
        } else {
            //let currentDate = SystemTool.currentDate("yyyyMMddHHmmss")
            for dict in resultDataArr! {
                DLprint(dict)
                let modal = DLWKHistoryModal(id: Int(dict["id"] as! String)!, title: dict["hTitle"] as! String, url: dict["hUrl"] as! String, date: dict["hDate"] as! String)
                /*
                switch dict["hDate"] as! String {
                case let date where date < "20111010101010":
                    <#code#>
                default:
                    <#code#>
                }*/
                webHistory.append(modal)
                tableView.reloadData()
            }
        }
    }
    
    //MARK:- table view datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        let modal = webHistory[indexPath.row]
        cell?.textLabel?.text = modal.title
        cell?.detailTextLabel?.text = modal.url
        return cell!
    }
    
    
    
    //MARK:- table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DLprint("cell - \(indexPath.row)")
        let url: URL = URL.init(string: webHistory[indexPath.row].url)!
        self.dismiss(animated: true, completion: {() -> Void in
            if self.delegate != nil {
                self.delegate.dlWKHistoryOpenPage(with: url)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
