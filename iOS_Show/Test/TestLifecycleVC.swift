//
//  TestLifecycleVC.swift
//  iOS_Show
//
//  Created by dali on 2016/11/7.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import WebKit

class TestLifecycleVC: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    var web: DLWebView!
    var config = WKWebViewConfiguration()
    var isLoadComplete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setWebViewConfig()
        addWebView()
        
        loadAllUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DLprint("")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DLprint("")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DLprint("")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        web.removeProgressObserver()
        config.userContentController.removeScriptMessageHandler(forName: "Superdali")
        DLprint("")
    }
    
    func loadAllUI() {
        let backBtn: UIButton = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        view.addSubview(backBtn)
        
        backBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 50, height: 20))
            make.center.equalTo(view)
        }
        
    }
    
    /**
     配置WebView的Config
     */
    func setWebViewConfig() {
        // 配置信息
        // Webview的偏好设置
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        // 通过js与webview内容交互配置
        config.userContentController = WKUserContentController()
        
        /*
         // 添加一个JS到HTML中，这样就可以直接在JS中调用我们添加的JS方法
         let script = WKUserScript(source: "function showAlert() { alert('在载入webview时通过Swift注入的JS方法'); }",
         injectionTime: .AtDocumentStart,// 在载入时就添加JS
         forMainFrameOnly: true) // 只添加到mainFrame中
         config.userContentController.addUserScript(script)
         */
        
        // 添加一个名称，就可以在JS通过这个名称发送消息：
        // window.webkit.messageHandlers.AppModel.postMessage({body: 'xxx'})
        
        config.userContentController.add(self, name: "Superdali")
    }
    
    /**
     添加WebView到页面
     */
    func addWebView() {
        
        let webView_W: CGFloat = self.view.frame.size.width
        let webView_H: CGFloat = self.view.frame.size.height - 20
        web = DLWebView(frame: CGRect(x: 0, y: 20, width: webView_W, height: webView_H), configuration: config)
        web.navigationDelegate = self
        web.uiDelegate = self
        web.allowsBackForwardNavigationGestures = false
        self.view.addSubview(web)
    }

    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: WKNavigationDelegate
    // WKNavigationDelegate主要处理一些跳转、加载处理操作。
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //DLprint("didStartProvisionalNavigation --- 页面开始加载")
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //DLprint("didCommitNavigation --- 内容开始返回")
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //DLprint("didFinishNavigation --- 页面加载完成")
        web.progressView.setProgress(0.0, animated: false)
        isLoadComplete = true
        
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //DLprint("didFailProvisionalNavigation --- 页面加载失败时调用")
        //MBProgressHUD.showError("加载失败")
        web.progressView.setProgress(0.0, animated: false)
    }
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        //DLprint("didReceiveServerRedirectForProvisionalNavigation --- 接收到服务器跳转请求")
    }
    // 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //DLprint("decidePolicyForNavigationResponse --- 在收到响应后，决定是否跳转")
        decisionHandler(.allow)
    }
    // 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //DLprint("decidePolicyForNavigationAction --- 在发送请求之前，决定是否跳转")
        //        NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        let url = navigationAction.request.url!.absoluteString
        DLprint("url = \(url)")
        decisionHandler(.allow)
    }
    
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        /*
         DLprint(message.body)
         // 如果在开始时就注入有很多的名称，那么我们就需要区分来处理
         if message.name == "AppModel" {
         DLprint("message name is AppModel")
         }
         if message.name == "Superdali" {
         DLprint("Superdali ==== Superdali ==== Superdali")
         }
         */
    }
    
    // MARK: - WKUIDelegate
    // WKUIDelegate主要处理JS脚本，确认框，警告框等
    
    // 这个方法是在HTML中调用了JS的alert()方法时，就会回调此API。
    // 注意，使用了`WKWebView`后，在JS端调用alert()就不会在HTML
    // 中显示弹出窗口。因此，我们需要在此处手动弹出ios系统的alert。
    /**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param frame             主窗口
     *  @param completionHandler 警告框消失调用
     */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        //DLprint("runJavaScriptAlertPanelWithMessage")
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            // We must call back js
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        //DLprint("runJavaScriptConfirmPanelWithMessage")
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            // 点击完成后，可以做相应处理，最后再回调js端
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) -> Void in
            // 点击取消后，可以做相应处理，最后再回调js端
            completionHandler(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        //DLprint("runJavaScriptTextInputPanelWithPrompt")
        let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.textColor = UIColor.red
        }
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            // 处理好之前，将值传到js端
            completionHandler(alert.textFields![0].text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        DLprint("====== deinit =======")
    }

}
