//
//  DLUIWebViewVC.swift
//  iOS_Show
//
//  Created by dali on 17/03/2017.
//  Copyright © 2017 dali. All rights reserved.
//

import UIKit

class DLUIWebViewVC: UIViewController, UIWebViewDelegate {
    
    var web: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadAllUI()

        DLprint(web)
    }
    
    func loadAllUI() {
        web = UIWebView(frame: view.frame)
        web.delegate = self
        
        // UIWebPaginationMode
//        web.paginationMode = .unpaginated
//        web.paginationMode = .leftToRight
//        web.paginationMode = .topToBottom
//        web.paginationMode = .bottomToTop
//        web.paginationMode = .rightToLeft
        
        web.paginationBreakingMode = .column
        
        
        view.addSubview(web)
        
        let webURL: URL = Bundle.main.url(forResource: "UIWebView", withExtension: "html")!
        let request: URLRequest = URLRequest(url: webURL)
        web.loadRequest(request)
        
    }
    
    //MARK:- UI Web View Delegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        DLprint("shouldStartLoadWith")
        DLprint("navigationType:\(navigationType.rawValue)")
        DLprint("request.url:\(String(describing: request.url))")
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        DLprint("webViewDidStartLoad")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        DLprint("didFailLoadWithError")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DLprint("webViewDidFinishLoad")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
