//
//  DLDirectoryTool.swift
//  UIShow_Swift
//
//  Created by dali on 16/8/22.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit



class DLDirectoryTool: NSObject {
    
    // 沙盒Document目录
    fileprivate static let dirDocURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    fileprivate static let dirLibURL: URL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
    // 文件管理
    fileprivate static let fileManager = FileManager.default
    
    /*
    /// 沙盒目录
    // Document目录
    fileprivate static let boxDocPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    // Library目录
    fileprivate static let boxLibPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    */
    
    
    
    
    
    /**
     获取沙盒Document目录
     - returns: 目录
     */
    internal class func dirPath() -> String {
        return dirDocURL.path
    }
    
    /**
     获取文件的目录
     - parameter name: 文件名称
     - returns: 文件目录
     */
    internal class func directoryPath(name:String) -> String {
        return dirDocURL.appendingPathComponent(name).path
    }
    
    /**
     创建文件夹
     - parameter name: 文件夹名
     - returns: 是否成功
     */
    internal class func createDirectory(name:String) -> Bool {
        if !directoryIsExist(name: name) {
            do {
                try fileManager.createDirectory(atPath: directoryPath(name: name), withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                DLprint("创建文件夹失败")
                return false
            }
        }
        return true
    }
    
    /**
     文件夹是否存在
     - parameter name: 文件夹名
     - returns: 是否存在
     */
    internal class func directoryIsExist(name:String) -> Bool {
        let dirPath = dirDocURL.appendingPathComponent(name).path
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: dirPath, isDirectory: &isDir) {
            if isDir.boolValue {
                //print("file exist and is a directory")
                return true
            }
            else {
                //print("file exist and is not a directory")
                return false
            }
        }
        else {
            //print("file does not exist")
            return false
        }
    }
    
    /**
     删除文件
     - parameter name: 文件名
     - returns: 是否删除成功
     */
    internal class func deleteDirectory(name:String) -> Bool {
        let dirPath = dirDocURL.appendingPathComponent(name).path
        do {
            try fileManager.removeItem(atPath: dirPath)
        }
        catch {
            print("删除文件夹失败")
            return false
        }
        return true
    }
}
