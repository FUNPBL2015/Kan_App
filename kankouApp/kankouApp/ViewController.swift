//
//  ViewController.swift
//  kankouApp
//
//  Created by 岩見建汰 on 2015/06/17.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myButton1: UIButton!
    var myButton2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.hidesBarsOnTap = true
        
        // Buttonを生成する.
        myButton1 = UIButton()
        myButton2 = UIButton()
        
        // サイズを設定する.
        myButton1.frame = CGRectMake(0,0,185,55)
        myButton2.frame = CGRectMake(0,0,185,55)
        
        // 背景色を設定する.
        var myButton1Color = UIColor(red: 0.0, green: 0.75, blue: 1.0, alpha: 1.0)  //1 0.5 0.14
        myButton1.backgroundColor = myButton1Color
        // myButton1.backgroundColor = UIColor.blueColor()
        myButton2.backgroundColor = myButton1Color
        
        // 枠を丸くする.
        myButton1.layer.masksToBounds = true
        myButton2.layer.masksToBounds = true
        
        // タイトルを設定する(通常時).
        myButton1.setTitle("観光スポット情報", forState: UIControlState.Normal)
        myButton1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        myButton2.setTitle("木古内のお天気", forState: UIControlState.Normal)
        myButton2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        // コーナーの半径を設定する.
        myButton1.layer.cornerRadius = 20.0
        myButton2.layer.cornerRadius = 20.0
        
        // ボタンの位置を指定する.
        myButton1.layer.position = CGPoint(x: self.view.frame.width/2-14, y:210)
        myButton2.layer.position = CGPoint(x: self.view.frame.width/2+14, y:300)
        
        // タグを設定する.
        myButton1.tag = 1
        myButton2.tag = 2
        
        // イベントを追加する.
        myButton1.addTarget(self, action: "ClickMyButton1:", forControlEvents: .TouchUpInside)
        myButton2.addTarget(self, action: "ClickMyButton2:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(myButton1)
        self.view.addSubview(myButton2)

    }

    /*
    ボタンのアクション時に設定したメソッド.
    */
    func ClickMyButton1(sender: UIButton){
        myButton1.alpha = 0.5
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("tourmap")
        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    
    func ClickMyButton2(sender: UIButton){
        myButton2.alpha = 0.5
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("weather")
        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

