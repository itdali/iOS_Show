//
//  TestWKWebVC.swift
//  iOS_Show
//
//  Created by dali on 16/11/4.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import WebKit

class TestWKWebVC: DLBasicWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        loadAllUI()
    }
    
    func loadAllUI() {
        //web.loadRequestWithName(fileName: "indexx", ofType: "html")
        //web.loadRequestWithURLString(urlString: "http://www.google.com")
        web.loadRequestWithURLString(urlString: "http://11.163.106.141:51000/EPServer_S/pub-page/mainPanel.html?BoxType=12601&LoginNo=aa021A&LoginPwd=0a49de933d2eb25f7e5941bc7ea94546")
        
        // 添加关闭按钮
        let closeWebBtn = UIButton.init(frame: CGRect(x: 50, y: 12, width: 40, height: 30))
        closeWebBtn.setTitle("关闭", for: .normal)
        closeWebBtn.setTitleColor(UIColor.orange, for: .normal)
        closeWebBtn.titleLabel!.font = UIFont.systemFont(ofSize: 17)
        closeWebBtn.addTarget(self, action: #selector(self.closeWebClick), for: UIControlEvents.touchUpInside)
        web.addSubview(closeWebBtn)
    }
    func closeWebClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: WKNavigationDelegate
    // WKNavigationDelegate主要处理一些跳转、加载处理操作。
    // 页面开始加载时调用
    override func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        super.webView(webView, didStartProvisionalNavigation: navigation)
        DLprint("didStartProvisionalNavigation --- 页面开始加载")
    }
    // 当内容开始返回时调用
    override func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        super.webView(webView, didCommit: navigation)
        DLprint("didCommitNavigation --- 内容开始返回")
    }
    // 页面加载完成之后调用
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        DLprint("didFinishNavigation --- 页面加载完成")
        web.progressView.setProgress(0.0, animated: false)
        isLoadComplete = true
    }
    // 页面加载失败时调用
    override func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        super.webView(webView, didFailProvisionalNavigation: navigation, withError: error)
        DLprint("didFailProvisionalNavigation --- 页面加载失败时调用")
        
        DLAlert().showAlert("页面加载失败", subTitle: " ", cancleBtnTitle: "返回", actionL: {() -> Void in
            self.dismiss(animated: true, completion: nil)
        }, confirmBtnTitle: "重试"){() -> Void in
            self.web.progressView.setProgress(0.0, animated: false)
            self.web.loadRequestWithURLString(urlString: self.currentURL)
        }
    }
    // 接收到服务器跳转请求之后调用
    override func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        super.webView(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
        DLprint("didReceiveServerRedirectForProvisionalNavigation --- 接收到服务器跳转请求")
    }
    // 在收到响应后，决定是否跳转
    override func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        super.webView(webView, decidePolicyFor: navigationResponse){(wkNav: WKNavigationResponsePolicy) -> Void in}
        DLprint("decidePolicyForNavigationResponse --- 在收到响应后，决定是否跳转")
        decisionHandler(.allow)
    }
    // 在发送请求之前，决定是否跳转
    override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        super.webView(webView, decidePolicyFor: navigationAction){(wkNav: WKNavigationActionPolicy) -> Void in}
        DLprint("decidePolicyForNavigationAction --- 在发送请求之前，决定是否跳转")
        decisionHandler(.allow)
    }
    
    deinit {
        DLprint("======= deinit ========")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
