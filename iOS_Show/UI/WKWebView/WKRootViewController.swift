//
//  WKRootViewController.swift
//  WKBrowser
//
//  Created by dali on 10/04/2017.
//  Copyright © 2017 itdali. All rights reserved.
//

import UIKit
import WebKit

class WKRootViewController: UIViewController {
    
    private var web: WKWebView!
    private var progressView: UIProgressView!
    private var isBackEnabled: Bool = false
    private var backList: [WKBackForwardListItem] = []
    private var toolBar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        

        loadWebView()
        //loadToolBar()
    }
    
    //MARK:- load web view
    func loadWebView() {
        let config: WKWebViewConfiguration = WKWebViewConfiguration()
        // set preferences
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        config.preferences.minimumFontSize = 10
        // init userContentController
        config.userContentController = WKUserContentController()
        // don't know how to use
        // let userScript = WKUserScript(source: "http://localhost/H5/js/WKWebView.js", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        // config.userContentController.addUserScript(userScript)
        // add 'testFunc' to web
        //config.userContentController.add(self, name: testFunc)
        if #available(iOS 10.0, *) {
            // text will be transformed to be link
            config.dataDetectorTypes = [.link, .phoneNumber]
        } else {
            // Fallback on earlier versions
        }
        
        web = WKWebView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64-49), configuration: config)
        //webOldPoint = web.scrollView.contentOffset
        //web.uiDelegate = self
        //web.navigationDelegate = self
        //web.scrollView.delegate = self
        web.allowsBackForwardNavigationGestures = true
        view.addSubview(web)
        
        
        // add progress to web
        progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 2))
        progressView.setProgress(0.5, animated: true)
        progressView.progressTintColor = UIColor.blue
        progressView.trackTintColor = UIColor.white
        web.addSubview(progressView)
        
        
        // add KVO to web
        web.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "url", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "isLoading", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "canGoForward", options: .new, context: nil)
        
        /*
         // load page in project
         if let webUrl = Bundle.main.url(forResource: "WKWebView", withExtension: "html") {
         web.load(URLRequest(url: webUrl))
         } else {
         showErrorLinkPage()
         }*/
        
        
        // load page in localhost - Apache
        //let strUrl: String = "http://www.baidu.com"
        let strUrl: String = "http://localhost/H5/page/WKWebView.html"
        //let strUrl: String = "https://sojump.com/jq/12918125.aspx"
        if let webUrl = URL(string: strUrl){
            web.load(URLRequest(url: webUrl))
        } else {
            showErrorLinkPage()
        }
    }
    /// show error message when the link is wrong
    func showErrorLinkPage() {
        MBProgressHUD.showError("The link is wrong!")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            DLprint("estimatedProgress: \(web.estimatedProgress)")
            progressView.setProgress(Float(web.estimatedProgress), animated: true)
            progressView.isHidden = web.estimatedProgress == 1
        }
        if keyPath == "title" {
            if let webTitle = web.title {
                DLprint("observeValue - title: \(webTitle)")
                self.title = webTitle
            }
        }
        if keyPath == "url" {
            if let webUrl = web.url {
                DLprint("observeValue - url: \(webUrl)")
            }
        }
        if keyPath == "isLoading" {
            DLprint("observeValue - web.isLoading: \(web.isLoading)")
        }
        if keyPath == "canGoBack" {
            DLprint("observeValue - canGoBack: \(web.canGoBack)")
        }
        if keyPath == "canGoForward" {
            DLprint("observeValue - canGoForward: \(web.canGoForward)")
        }
    }
    
    
    //MARK:- tool bar
    func loadToolBar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: kScreenHeight-49, width: kScreenWidth, height: 49))
        
        // 下面两个配色可以用于夜间版
        //toolBar.barStyle = .blackTranslucent
        //toolBar.tintColor = UIColor.gray
        
        let toolBarBtnA = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(toolBarBtnClick))
        let toolBarBtnB = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshClick))
        let toolBarBtnC = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(toolBarBtnClick))
        let toolBarBtnD = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(historyClick))
        let toolBarBtnE = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toolBarBtnClick))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // A,B,C,D,E
        toolBar.setItems([toolBarBtnA,flexibleSpace,toolBarBtnB,flexibleSpace,toolBarBtnC,flexibleSpace,toolBarBtnD,flexibleSpace,toolBarBtnE], animated: true)
        view.addSubview(toolBar)
    }
    func toolBarBtnClick() {
        DLprint("toolBarBtnClick")
    }
    func historyClick() {
        DLprint("")
        /*
        let historyVC = DLWKHistory()
        historyVC.delegate = self
        self.present(historyVC, animated: true, completion: {() -> Void in
            DLprint("present to historyVC completion: {() -> Void in }")
        })*/
    }
    func refreshClick() {
        DLprint("")
        web.reload()
    }
    
    //MARK:- deinit
    deinit {
        DLprint("")
        web.removeObserver(self, forKeyPath: "estimatedProgress")
        web.removeObserver(self, forKeyPath: "title")
        web.removeObserver(self, forKeyPath: "url")
        web.removeObserver(self, forKeyPath: "isLoading")
        web.removeObserver(self, forKeyPath: "canGoBack")
        web.removeObserver(self, forKeyPath: "canGoForward")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
