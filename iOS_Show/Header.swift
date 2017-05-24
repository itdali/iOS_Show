//
//  Header.swift
//  iOS-Show
//
//  Created by dali on 16/4/29.
//  Copyright © 2016年 dali. All rights reserved.
//
// =============== 自定义全局的变量、语句等 ======================

import Foundation



// ====================    WebViewURL    ===========================
// WebViewURL
public let WebViewURL: String = "http://localhost/LocalTest"
// 各个页面的URL
public let IndexWebURL: String = "\(WebViewURL)/index.html"
// ====================    WebViewURL    ===========================



/// 沙盒目录
public let boxDocPath: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
public let boxLibPath: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString




// ====================    系统颜色    ===========================
// 系统颜色
/// 系统主色调的蓝色  #2E90DF
public let SystemBlue: UIColor = UIColor(red: 46/255.0, green: 144/255.0, blue: 223/255.0, alpha: 1.0)
// 登录页获取验证码背景色
public let SystemGetVerifyGreen: UIColor = UIColor(red: 128/255.0, green: 180/255.0, blue: 51/255.0, alpha: 1.0)
// ====================    系统颜色    ===========================


// ====================    屏幕尺寸    ===========================
public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
// ====================    屏幕尺寸    ===========================





/**
 自定义输出语句，代替系统输出，打包时禁掉即可
 
 - parameter message: 要输出的内容
 - parameter file:    文件名
 - parameter method:  方法名
 - parameter line:    行号
 */


/// 自定义输出语句，代替系统输出，打包时禁掉即可
///
/// - Parameters:
///   - message: 要输出的内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行号
public func DLprint <T>(_ message: T,
    file: String = #file,
    method: String = #function,
    line: Int = #line)
{
    //print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    print("\((file as NSString).lastPathComponent)[\(line)]: \(message)")
}

