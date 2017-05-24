//
//  DataViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet var showLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    @IBAction func showPath() {
        DLprint(DLDirectoryTool.dirPath())
    }
    
    //MARK:- Preference
    private let defaults:UserDefaults = UserDefaults.standard
    @IBAction func prefrSaveBtn() {
        defaults.setValue("abcde", forKey: "abc")
        if defaults.synchronize() {showLabel.text = "save successful"}
        else {showLabel.text = "save faile"}
    }
    @IBAction func prefrReadBtn() {
        if defaults.string(forKey: "abc") != nil {showLabel.text = defaults.string(forKey: "abc")!}
        else {showLabel.text = "read faile"}
    }
    
    //MARK:- Plist
    let dataArray: NSArray = [[
        "user":"10011",
        "phone":"13812345678",
        "address":"beijing",
        "age":"25"
        ]]
    let fileManager = FileManager.default
    @IBAction func plistSaveBtn() {
        var mutableArray: NSMutableArray = NSMutableArray()
        let plistPath = boxDocPath.appendingPathComponent("data.plist")
        if fileManager.fileExists(atPath: plistPath) {
            if NSMutableArray(contentsOfFile: plistPath) != nil {
                mutableArray = NSMutableArray(contentsOfFile: plistPath)!
                mutableArray.add(dataArray[0])
            }
            else {mutableArray.add(dataArray[0])}
        }
        else {mutableArray.add(dataArray[0])}
        if mutableArray.write(toFile: plistPath, atomically: true) {
            showLabel.text = "write success"
        }
    }
    @IBAction func plistReadBtn() {
        var mutableArray: NSMutableArray = NSMutableArray()
        let plistPath = boxDocPath.appendingPathComponent("data.plist")
        if fileManager.fileExists(atPath: plistPath) {
            if NSMutableArray(contentsOfFile: plistPath) != nil {
                mutableArray = NSMutableArray(contentsOfFile: plistPath)!
                showLabel.text = "arrayCount = \(mutableArray.count)"
            }
            else {showLabel.text = "Failed to open the data.plist"}
        }
        else {showLabel.text = "data.plist is not exist"}
    }
    
    //MARK:- Zip
    @IBAction func createZipBtn() {
        if DLDirectoryTool.directoryIsExist(name: "zip") {DLprint("123")}
        else {if !DLDirectoryTool.createDirectory(name: "zip") {showLabel.text = "创建文件夹失败"; return}}
        let destinationPath = boxDocPath.appendingPathComponent("zip/zip.zip")
        let imagePath:String = Bundle.main.path(forResource: "zip", ofType: "png")!
        DLprint(imagePath)
        let fileArray = NSArray(object: imagePath)
        let successUnZip: Bool = SSZipArchive.createZipFile(atPath: destinationPath, withFilesAtPaths: fileArray as [AnyObject])
        if successUnZip {showLabel.text = "压缩成功"}
        else {showLabel.text = "压缩失败"}
    }
    @IBAction func unZipBtn() {
        if DLDirectoryTool.directoryIsExist(name: "unzip") {DLprint("123")}
        else {if !DLDirectoryTool.createDirectory(name: "unzip") {showLabel.text = "创建文件夹失败"; return}}
        let zipPath = boxDocPath.appendingPathComponent("zip/zip.zip")
        let destinationPath = boxDocPath.appendingPathComponent("unzip")
        let successUnZip: Bool = SSZipArchive.unzipFile(atPath: zipPath, toDestination: destinationPath)
        if successUnZip {showLabel.text = "解压成功"}
        else {showLabel.text = "解压失败"}
    }
    
    //MARK:- JSON
    let jsonStr = "{\"ROOT\":{\"NUM\":13,\"STR\":\"aa021A\",\"ARRAY\":[{\"NAME\":\"abcde\",\"VALUE\":\"4533221\"},{\"NAME\":\"efcdb\",\"VALUE\":\"4566332\"}]}}"
    @IBAction func jsonParse() {
        
        /*
        // String => JSON
        let json = JSON(jsonStr)
        DLprint(json)
        
        // JSON => String
        let ROOT = json["ROOT"]
        let NUM = ROOT["NUM"]
        DLprint(NUM)
        
        // type check
        if ROOT["NUM"].isInt {
            DLprint("NUM is Int")
        } else {
            DLprint("NUM is not Int")
        }
        
        if json["ROOT"]["ARRAY"].isArray {
            DLprint("ARRAY is Array")
        } else {
            DLprint("ARRAY is not Array")
        }*/
    }
    @IBAction func jsonStringify() {
        
    }
    
    
    @IBAction func QRcodeBtn() {
        self.present(DLQRCodeVC(), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        DLprint("====== deinit ======")
    }

}
