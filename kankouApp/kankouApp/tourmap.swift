//
//  tourmap.swift
//  kankouApp
//
//  Created by 山川拓也 on 2015/06/20.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit

class tourmap: UIViewController {

    @IBOutlet weak var gourmetBtn: UIButton! //グルメボタン
    @IBOutlet weak var tourBtn: UIButton! //観光ボタン
    @IBOutlet weak var souvenirBtn: UIButton! //お土産ボタン
    
    
    
    //右上の天気関連
    
    private var myWeatherWindowInBar: UIWindow!
    private var myOpenButton: UIButton!
    private var myCloseWindow: UIWindow!
    private var myCloseButton: UIButton!
    private var myWindow: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 天気関連
        myWeatherWindowInBar = UIWindow()
        myOpenButton = UIButton()
        myWindow = UIWindow()
        myCloseWindow = UIWindow()
        myCloseButton = UIButton()
        makeWeatherWindowInBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //グルメをタップした時の動作
    @IBAction func tapGourmet(sender: AnyObject) {
    }
    
    //観光をタップした時の動作
    @IBAction func tapTour(sender: AnyObject) {
    }
    
    //お土産をタップした時の動作
    @IBAction func tapSouvenir(sender: AnyObject) {
    }
    
    //天気関連
    internal func makeWeatherWindowInBar(){
        
        // 背景を設定
        myWeatherWindowInBar.backgroundColor = UIColor.redColor()
        myWeatherWindowInBar.frame = CGRectMake(0, 0, 100, 45)
        myWeatherWindowInBar.layer.position = CGPointMake(self.view.frame.width-50, 42)
        
        // windowを表示する.
        self.myWeatherWindowInBar.makeKeyAndVisible()
        
        // ボタンを作成する.
        myOpenButton.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        myOpenButton.backgroundColor = UIColor.clearColor()
        myOpenButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        myOpenButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.myWeatherWindowInBar.addSubview(myOpenButton)
    }
    
    //myWindowを消すために画面いっぱいに透明なCloseボタンを配置
    internal func makeCloseWindow(){
        
        // 背景を設定
        myCloseWindow.backgroundColor = UIColor.clearColor()
        myCloseWindow.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        myCloseWindow.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        
        // windowを表示する.
        self.myCloseWindow.makeKeyAndVisible()
        
        // ボタンを作成する.
        myCloseButton.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        myCloseButton.backgroundColor = UIColor.clearColor()
        myCloseButton.layer.position = CGPointMake(self.myCloseWindow.frame.width/2, self.myCloseWindow.frame.height/2)
        myCloseButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.myCloseWindow.addSubview(myCloseButton)
    }
    
    internal func makeWeatherWindow(){
        
        // 背景を設定
        myWindow.backgroundColor = UIColor.blueColor()
        myWindow.frame = CGRectMake(0, 0, 200, 300)
        myWindow.layer.position = CGPointMake(self.view.frame.width-100, 215)
        myWindow.alpha = 0.5
        
        // windowを表示する.
        self.myWindow.makeKeyAndVisible()
        
        // TextViewを作成する.
        let myTextView: UITextView = UITextView(frame: CGRectMake(10, 10, self.myWindow.frame.width - 20, 150))
        myTextView.backgroundColor = UIColor.clearColor()
        myTextView.text = "どうにかして天気表示してください このウィンドウの大きさは自由にいじってね"
        myTextView.font = UIFont.systemFontOfSize(CGFloat(15))
        myTextView.textColor = UIColor.whiteColor()
        myTextView.textAlignment = NSTextAlignment.Center
        myTextView.editable = false
        self.myWindow.addSubview(myTextView)
    }
    
    internal func onClickMyButton(sender: UIButton) {
        if sender == myCloseButton {
            myWindow.hidden = true
            myCloseWindow.hidden = true
        }else if sender == myOpenButton{
            makeCloseWindow()
            makeWeatherWindow()
        }
    }
    
    @IBAction func returnBtn(sender: AnyObject) {
        myWindow.hidden = true
        myCloseWindow.hidden = true
        myWeatherWindowInBar.hidden = true
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
