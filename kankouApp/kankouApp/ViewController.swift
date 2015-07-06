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
    
    @IBOutlet weak var nowimage: UIImageView!
    @IBOutlet weak var nowtemp: UILabel!
    @IBOutlet weak var maxtemp: UILabel!
    @IBOutlet weak var mintemp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.hidesBarsOnTap = true
        
        var maxTemp: String
        var minTemp: String
        var nowTemp: String
        var nowWeatherImage: UIImage
        
        var request = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Kikonai,jp&APPID=929cccb5476e5965410a401bf0efe12a")!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON(data:data!)
        nowTemp = NSString(format: "%.1f", json["main"]["temp"].doubleValue - 273.15) as! String
        maxTemp = NSString(format: "%.1f", json["main"]["temp_max"].doubleValue - 273.15) as! String
        minTemp = NSString(format: "%.1f", json["main"]["temp_min"].doubleValue - 273.15) as! String
        nowWeatherImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://openweathermap.org/img/w/"+json["weather"][0]["icon"].string!+".png")!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)!)!

        nowtemp.text = nowTemp
        maxtemp.text = maxTemp
        mintemp.text = minTemp
        nowimage.image = nowWeatherImage
        
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
        myButton1.setTitle("観光する", forState: UIControlState.Normal)
        myButton1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        myButton2.setTitle("振り返る", forState: UIControlState.Normal)
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
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("category")
        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    
    func ClickMyButton2(sender: UIButton){
        myButton2.alpha = 0.5
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("photostory")
        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

