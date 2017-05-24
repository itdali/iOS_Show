//
//  DLWKWebViewVC.swift
//  iOS_Show
//
//  Created by dali on 18/03/2017.
//  Copyright © 2017 dali. All rights reserved.
//

import UIKit
import WebKit


class DLWKWebViewVC: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,DLWKHistoryDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate {
    
    private var web: WKWebView!
    private var progressView: UIProgressView!
    private var isBackEnabled: Bool = false
    private var backList: [WKBackForwardListItem] = []
    private var toolBar: UIToolbar!
    
    
    // JS to Native function name
    private let testFunc: String = "testFunc"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        //self.title = "WKWebView"
        DLprint("\n\n\n\n\n\n\n====== DLWKWebViewVC ======\n")

        
        //addNavigationBarBtn()
        loadWebView()
        //addToolBar()
        
        /*
        let wkWebView = WKWebView(frame: CGRect.zero)
        wkWebView.evaluateJavaScript("navigator.userAgent", completionHandler: {(any: Any?,error: Error?) -> Void in
            DLprint(error)
        })*/
        
    }
    
    //MARK:- Navigation Bar Btn
    func addNavigationBarBtn() {
        // leftBarBtn
        let backBtn = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backClick))
        self.navigationItem.setLeftBarButtonItems([backBtn], animated: true)
        //self.navigationItem.setLeftBarButton(backBtn, animated: true)
    }
    func backClick() {
        DLprint("")
        if web.canGoBack {
            if let backItem = web.backForwardList.backItem {
                DLprint(backItem.url)
                web.goBack()
            }
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    func historyClick() {
        DLprint("")
        let historyVC = DLWKHistory()
        historyVC.delegate = self
        self.present(historyVC, animated: true, completion: {() -> Void in
            DLprint("present to historyVC completion: {() -> Void in }")
        })
    }
    func refreshClick() {
        DLprint("")
        web.reload()
    }
    
    //MARK:- tool bar
    func addToolBar() {
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
    
    //MARK:- load all UI
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
        webOldPoint = web.scrollView.contentOffset
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
    
    /*
    func addGestureToView() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureClick(_:)))
        pan.minimumNumberOfTouches = 2
        pan.maximumNumberOfTouches = 3
        view.addGestureRecognizer(pan)
    }
    func panGestureClick(_ sender: UIPanGestureRecognizer) {
        DLprint(sender)
    }*/
    
    
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
    
    
    

    //MARK:- WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        DLprint("decidePolicyFor navigationAction")
        if let url =  navigationAction.request.url{
            DLprint("Action.request.url: \(url.absoluteString)")
        }
        DLprint("navigationType: \(navigationAction.navigationType.hashValue)")
        
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        DLprint("decidePolicyFor navigationResponse")
        if let url = navigationResponse.response.url?.absoluteString {
            DLprint("Response.request.url: \(url)")
        }
        
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DLprint("didStartProvisionalNavigation")
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        DLprint("didReceiveServerRedirectForProvisionalNavigation")
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        DLprint("didFailProvisionalNavigation")
        DLprint(error)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        DLprint("didCommit")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DLprint("didFinish")
        
        if let backItem = webView.backForwardList.backItem {
            DLprint("backItem title: \(String(describing: backItem.title)), url: \(backItem.url)")
        }
        if let currentItem = webView.backForwardList.currentItem {
            if let currentTitle = currentItem.title {
                self.title = currentTitle
                addToHistory(current: currentItem)
            }
            DLprint("currentItem title: \(String(describing: currentItem.title)), url: \(currentItem.url)")
        }
        if let forwardItem = webView.backForwardList.forwardItem {
            DLprint("forwardItem title: \(String(describing: forwardItem.title)), url: \(forwardItem.url)")
        }
        
        /*
        let backList = webView.backForwardList.backList
        print("backList: \(backList)")
        for item in backList {
            print("title: \(item.title), url: \(item.url)")
        }
        
        let forwordList = webView.backForwardList.forwardList
        print("forwordList: \(forwordList)")
        for item in forwordList {
            print("title: \(item.title), url: \(item.url)")
        }*/
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DLprint("didFail")
        DLprint(error)
    }
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        DLprint("didReceive challenge")
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        DLprint("webViewWebContentProcessDidTerminate")
    }
    
    
    
    //MARK:- WKUIDelegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        DLprint("createWebViewWith configuration")
        return nil
    }
    func webViewDidClose(_ webView: WKWebView) {
        DLprint("webViewDidClose")
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        DLprint("runJavaScriptAlertPanelWithMessage")
        DLprint(message)
        let alert = UIAlertController(title: "alert", message: message, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(confirmBtn)
        self.present(alert, animated: true, completion: nil)
        completionHandler()
        
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        DLprint("runJavaScriptConfirmPanelWithMessage")
        DLprint(message)
        let confirm = UIAlertController(title: "confirm", message: message, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "Confirm", style: .default, handler: {(action) -> Void in
            completionHandler(true)
        })
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            completionHandler(false)
        })
        confirm.addAction(confirmBtn)
        confirm.addAction(cancelBtn)
        self.present(confirm, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        DLprint("runJavaScriptTextInputPanelWithPrompt")
        DLprint(prompt)
        DLprint(defaultText)
        let prompt = UIAlertController(title: "prompt", message: prompt, preferredStyle: .alert)
        prompt.addTextField(configurationHandler: {(textField) -> Void in
            DLprint("TextField - configurationHandler")
            textField.placeholder = defaultText
        })
        let confirmBtn = UIAlertAction(title: "Confirm", style: .default, handler: {(action) -> Void in
            completionHandler("")
        })
        prompt.addAction(confirmBtn)
        self.present(prompt, animated: true, completion: nil)
    }
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        DLprint("shouldPreviewElement")
        return true
    }
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
        DLprint("previewingViewControllerForElement")
        return self
    }
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        DLprint("commitPreviewingViewController")
    }
    
    
 
    //MARK:- WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DLprint("name: \(message.name), body: \(message.body)")
    }
    
    
    //MARK:- DLWKHistoryDelegate
    func dlWKHistoryOpenPage(with url: URL) {
        web.load(URLRequest(url: url))
    }
    //MARK:- update web view history
    func addToHistory(current item: WKBackForwardListItem) {
        var tempResult: Array<Int> = []
        let querySQL = "SELECT id,hUrl FROM 't_webview_history' order by id asc"
        var resultDataArr = SQLiteManager.shareInstance().queryDataBase(SQL: querySQL)
        if resultDataArr == nil {
            resultDataArr = []
            DLprint("表内暂无数据")
        } else {
            for dict in resultDataArr! {
                DLprint(dict)
                tempResult.append(Int(dict["id"] as! String)!)
            }
        }
        
        
        let currentDate = SystemTool.currentDate("yyyyMMddHHmmss")
        if tempResult.count > 0 {
            for id in tempResult {
                let updateSQL = "update t_webview_history set hTitle = '\(item.title!)', hUrl = '\(item.url)', hDate = \(currentDate) where id = \(id);"
                if SQLiteManager.shareInstance().exec(SQL: updateSQL) == true{
                    DLprint("修改成功")
                } else {
                    DLprint("修改失败")
                }
            }
        } else {
            let insertSQL = "insert into t_webview_history (hTitle,hUrl,hDate) values ('\(item.title!)','\(item.url)','\(currentDate)');"
            if SQLiteManager.shareInstance().exec(SQL: insertSQL) == true{
                DLprint("插入成功")
            } else {
                DLprint("插入失败")
            }
        }
    }
    
    
    
    //MARK:- UIScroll View Delegate
    // Dragging
    private var webOldPoint: CGPoint = CGPoint.zero
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        DLprint("scrollViewWillBeginDragging")
        webOldPoint = scrollView.contentOffset
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DLprint("scrollViewDidScroll - contentOffset: \(scrollView.contentOffset)")
        
        /*
        if webOldPoint.y - scrollView.contentOffset.y >= kScreenHeight*0.2 {
            DLprint("should show tool bar")
        } else {
            DLprint("should hide tool bar")
            if toolBar.frame.minY < kScreenHeight {
                var oldRect = toolBar.frame
                oldRect.origin.y += (webOldPoint.y - scrollView.contentOffset.y - kScreenHeight*0.2)
                toolBar.frame = oldRect
            }
        }*/
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        DLprint("scrollViewWillEndDragging")
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        DLprint("scrollViewDidEndDragging")
        webOldPoint = scrollView.contentOffset
    }
    // Zooming
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        DLprint("scrollViewWillBeginZooming")
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        DLprint("scrollViewDidZoom")
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        DLprint("scrollViewDidEndZooming")
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        DLprint("scrollViewShouldScrollToTop")
        return true
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        DLprint("scrollViewDidScrollToTop")
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        DLprint("scrollViewWillBeginDecelerating")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        DLprint("scrollViewDidEndDecelerating")
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        DLprint("scrollViewDidEndScrollingAnimation")
    }
    
    
    
    
    
    //MARK:- UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        DLprint("gesture - 1")
        DLprint(touch.view?.superclass)
        return true
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        DLprint("gesture - 2")
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        DLprint("gesture - 3")
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        DLprint("gesture - 4")
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        DLprint("gesture - 5")
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        DLprint("gesture - 6")
        return true
    }
    
        
    //MARK:- deinit
    deinit {
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
