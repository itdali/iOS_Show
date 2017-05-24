//
//  DLNavigationVC_Two.swift
//  iOS_Show
//
//  Created by dali on 2017/3/11.
//  Copyright © 2017年 dali. All rights reserved.
//

import UIKit

class DLNavigationVC_Two: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.backgroundColor = UIColor.orange
        
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        // Do any additional setup after loading the view.
    }
    
    // tableView - datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "cell - \(indexPath.row)"
        return cell
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "contentOffset") {
            DLprint(tableView.contentOffset.y)
            
            switch tableView.contentOffset.y {
            case let Y where Y > 0:
                self.navigationController?.navigationBar.subviews[0].alpha = 0
            case let Y where Y >= -64 && Y <= 0:
                self.navigationController?.navigationBar.subviews[0].alpha = (-Y)/64
            case let Y where Y < -64:
                self.navigationController?.navigationBar.subviews[0].alpha = 1
            default:
                self.navigationController?.navigationBar.subviews[0].alpha = 1
            }
        }
    }
    

    deinit {
        tableView.removeObserver(self, forKeyPath: "contentOffset", context: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
