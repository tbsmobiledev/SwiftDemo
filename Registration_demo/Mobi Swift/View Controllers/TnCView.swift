//
//  TnCView.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import WebKit

class TnCView: SIView,WKNavigationDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var webVw : WKWebView!
    
    var handler : ((Int)->())?
    
    func show(_ view:UIView ,complete : ((Int)->())?){
        handler = complete
        
        self.alpha = 0.0
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        contentView.alpha = 0.0
       
        view.addSubview(self)
        self.layoutIfNeeded()
        self.alpha = 1.0
        
        webVw.navigationDelegate = self
        webVw.scrollView.bounces = false
        let url = URL(string: "https://www.techcronus.com/privacy-policy/")
        webVw.load(URLRequest(url: url!))
        appDelegateShared.showHudder()
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
            self.contentView.alpha = 1.0
            self.layoutIfNeeded()
        }, completion: nil)
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath 
    }
    
    //MARK:- Webview delegate method
    func webView(_ webView: WKWebView,  didFinish navigation: WKNavigation!){
        appDelegateShared.hideHudder()
    }
    
    //MARK:- Action Events
    @IBAction func TapAcceptDecline(_ sender: UIControl) {
        if handler != nil {
            handler!(sender.tag == 101 ? 1:0)
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                self.contentView.alpha = 0
                self.layoutIfNeeded()
            }, completion: nil)
        }
        self.removeFromSuperview()
    }
}
