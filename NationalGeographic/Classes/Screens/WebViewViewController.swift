//
//  WebViewViewController.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebViewViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    var content: Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.content?.page?.title
        
        let url = URL(string: (self.content?.page?.url)!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension WebViewViewController: UIWebViewDelegate {
//    
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        SVProgressHUD.show()
//    }
//    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        SVProgressHUD.dismiss(withDelay: 3.0)
//    }
//}

