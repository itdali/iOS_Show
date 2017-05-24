//
//  DLWebView.swift
//  together
//
//  Created by dali on 16/8/30.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import WebKit

class DLWebView: WKWebView {
    
    var progressView: UIProgressView!
    var progressIsExist: Bool = false
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        
        progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 2))
        self.addSubview(progressView)
        // KVO监听
        self.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        progressIsExist = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 监听webView的estimatedProgress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = self.estimatedProgress == 1
            progressView.setProgress(Float(self.estimatedProgress), animated: true)
        }
    }
    
    /**
     根据URL加载页面
     
     - parameter url: URL
     
     - returns: WKNavigation
     */
    internal func loadRequestWithURLString(urlString url: String) {
        self.load(URLRequest(url: URL(string: url)!))
    }
    
    /**
     根据FilePath加载页面
     
     - parameter path: FilePath
     
     - returns: WKNavigation
     */
    internal func loadRequestWithFilePath(filePath path: String) {
        let dirDocURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.load(URLRequest(url: URL(fileURLWithPath: dirDocURL.appendingPathComponent(path).path)))
    }
    
    /**
     根据项目内路径页面加载页面
     - parameter path: 页面名称
     - returns: WKNavigation
     */
    internal func loadRequestWithName(fileName name: String, ofType type: String?) {
        let url: URL = Bundle.main.url(forResource: name, withExtension: type)!
        self.load(URLRequest(url: url))
    }
    
    /**
     移除Progress的监听
     */
    internal func removeProgressObserver() {
        if progressIsExist {
            self.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
        }
    }
}
