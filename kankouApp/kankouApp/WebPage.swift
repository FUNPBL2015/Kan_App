//
//  detail.swift
//  kankouApp
//
//  Created by 岩見建汰 on 2015/06/27.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit

class WebPage: UIViewController,UIWebViewDelegate{

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad(){
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
        var PinURL = appDelegate.PinURL
        WebView.delegate = self
        var URL = NSURL(string: PinURL!)
        var URLReq = NSURLRequest(URL: URL!)
        
        WebView.loadRequest(URLReq)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
