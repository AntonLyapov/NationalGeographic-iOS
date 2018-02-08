//
//  WebViewViewController.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var activityIndicatorView: UIActivityIndicatorView?
    
    var content: Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.content?.page?.title
        
        setupActivityIndicatorView()
        loadWebView()
    }
    
    func setupActivityIndicatorView() {
        self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.activityIndicatorView?.hidesWhenStopped = true
        self.activityIndicatorView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        let rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView!)
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    func loadWebView() {
        webView.navigationDelegate = self
        
        let url = URL(string: (self.content?.page?.url)!)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.activityIndicatorView?.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicatorView?.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicatorView?.stopAnimating()
    }
}
