//
//  DLWebViewVC.swift
//  UIShow_Swift
//
//  Created by dali on 16/9/13.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore


class DLWebViewVC: DLBasicWebViewController {
    
    var jsContext: JSContext!
    var closeWebBtn: UIButton!
    
    
    // H5页面注入的JS方法
    private let jsFunc: String = "JSFunction"
    private let svcFunc: String = "svcFunc"

    override func viewDidLoad() {
        super.viewDidLoad()

        addAllUI()
        
        DLprint(web)
        
        //addHeaderViewToWeb()
    }
    override func setWebViewConfig() {
        super.setWebViewConfig()
        
        // 这里添加页面返回按钮的触发JS方法
        config.userContentController.add(self, name: jsFunc)
        config.userContentController.add(self, name: svcFunc)
        
    }
    
    func addAllUI() {
//        web.loadRequestWithName(fileName: "wkIndex", ofType:"html")
        web.loadRequestWithURLString(urlString: "http://localhost/H5/page/WKWebView.html")
        
        // 添加关闭按钮
        // 添加关闭html5按钮  WK WebView 页面
        closeWebBtn = UIButton.init(frame: CGRect(x: 50, y: 12, width: 40, height: 30))
        closeWebBtn.setTitle("关闭", for: .normal)
        closeWebBtn.setTitleColor(UIColor.orange, for: .normal)
        closeWebBtn.titleLabel!.font = UIFont.systemFont(ofSize: 17)
        closeWebBtn.addTarget(self, action: #selector(self.closeWebClick), for: UIControlEvents.touchUpInside)
        //web.addSubview(closeWebBtn)
        
        
        let testBtn: UIButton = UIButton()
        testBtn.frame = CGRect(x: 150,  y: 12, width: 40, height: 30)
        testBtn.setTitle("test", for: .normal)
        testBtn.setTitleColor(UIColor.blue, for: .normal)
        testBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        testBtn.addTarget(self, action: #selector(testClick), for: UIControlEvents.touchUpInside)
        //web.addSubview(testBtn)
    }
    func closeWebClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // testBtn触发
    func testClick() {
        web.evaluateJavaScript("consol.log('哈哈');"){(any:Any?,error:Error?)->Void in
            if error != nil{
                DLprint(error.debugDescription)
            }
        }
    }
    
    //MARK:- web view delegate
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DLprint("name: \(message.name), body: \(message.body)")
        // 如果在开始时就注入有很多的名称，那么我们就需要区分来处理
        switch message.name {
        case jsFunc:
            DLprint("触发了HTML页的\(message.name)方法")
        case svcFunc:
            DLprint("触发了HTML页的\(message.name)方法")
            webFuncCallBack()
        default:
            break
        }
        
        super.userContentController(userContentController, didReceive: message)
    }
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
    }
    
    // web 调用 iOS 方法的回调
    func webFuncCallBack() {
        let dic: NSMutableDictionary = NSMutableDictionary()
        
        /*
        dic.setValue("Dali", forKey: "NAME")
        dic.setValue("18", forKey: "AGE")
        let param = JSON(dic).toString()
        web.evaluateJavaScript("serviceReturn(\(param));"){(any:Any?,error:Error?)->Void in
            if error != nil{
                DLprint(error.debugDescription)
            }
        }*/
    }
    
    
    //MARK:-  add headerView to WebView
    //webView是一个复合视图，里面包含有一个scrollView，scrollView里面是一个UIWebBrowserView（负责显示WebView的内容）
    func addHeaderViewToWeb() {
        
        let browserView: UIView = web.scrollView.subviews[0]
        let backHeadImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight*0.25))
        backHeadImageView.image = UIImage(named: "scroll_A")
        //把backHeadImageView插入到webView的scrollView下面
        web.insertSubview(backHeadImageView, belowSubview: browserView)
        
        //更改webBrowserView的frame向下移backHeadImageView的高度，使其可见
        var frame = browserView.frame
        frame.origin.y = backHeadImageView.frame.maxY
        browserView.frame = frame
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
