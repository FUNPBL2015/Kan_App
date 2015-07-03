//
//  weather.swift
//  kankouApp
//
//  Created by 山川拓也 on 2015/06/20.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit
import Foundation

class weather: UIViewController {
    @IBOutlet weak var weather09: UIImageView!
    @IBOutlet weak var weather12: UIImageView!
    @IBOutlet weak var weather15: UIImageView!
    @IBOutlet weak var weather18: UIImageView!
    @IBOutlet weak var weather21: UIImageView!
    @IBOutlet weak var temp09: UILabel!
    @IBOutlet weak var temp12: UILabel!
    @IBOutlet weak var temp15: UILabel!
    @IBOutlet weak var temp18: UILabel!
    @IBOutlet weak var temp21: UILabel!

    @IBOutlet weak var nowWeather: UIImageView!
    @IBOutlet weak var nowTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    @IBOutlet weak var weekly1: UIImageView!
    @IBOutlet weak var weekly2: UIImageView!
    @IBOutlet weak var weekly3: UIImageView!
    @IBOutlet weak var weekly4: UIImageView!
    @IBOutlet weak var weekly5: UIImageView!
    @IBOutlet weak var weekly6: UIImageView!
    @IBOutlet weak var weekly7: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //天気情報の取得と表示の更新
        var weather = GetWeather()
        nowWeather.image = weather.nowWeatherImage
        nowTemp.text = weather.nowTemp
        maxTemp.text = weather.maxTemp + "℃"
        minTemp.text = weather.minTemp + "℃"
        
        weather09.image = weather.forecastWeatherImage[0]
        weather12.image = weather.forecastWeatherImage[1]
        weather15.image = weather.forecastWeatherImage[2]
        weather18.image = weather.forecastWeatherImage[3]
        weather21.image = weather.forecastWeatherImage[4]
        temp09.text = weather.forecastTemp[0]
        temp12.text = weather.forecastTemp[1]
        temp15.text = weather.forecastTemp[2]
        temp18.text = weather.forecastTemp[3]
        temp21.text = weather.forecastTemp[4]
        
        weekly1.image = weather.weeklyWeatherImage[0]
        weekly2.image = weather.weeklyWeatherImage[1]
        weekly3.image = weather.weeklyWeatherImage[2]
        weekly4.image = weather.weeklyWeatherImage[3]
        weekly5.image = weather.weeklyWeatherImage[4]
        weekly6.image = weather.weeklyWeatherImage[5]
        weekly7.image = weather.weeklyWeatherImage[6]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

class GetWeather {
    var nowWeather: String
    var nowTemp: String
    var nowWeatherImage: UIImage
    var maxTemp: String
    var minTemp: String
    
    var forecastTemp: [String] = []
    var forecastWeather: [String] = []
    var forecastWeatherImage: [UIImage] = []
    var forecastTime: [String] = []
    
    var weeklyMaxTemp: [String] = []
    var weeklyMinTemp: [String] = []
    var weeklyWeather: [String] = []
    var weeklyWeatherImage: [UIImage] = []
    
    init() {
        //現在の天気情報の取得
        var request = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Kikonai,jp&APPID=929cccb5476e5965410a401bf0efe12a")!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON(data:data!)
        nowWeather = json["weather"][0]["main"].string!
        nowTemp = NSString(format: "%.1f", json["main"]["temp"].doubleValue - 273.15) as! String
        nowWeatherImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://openweathermap.org/img/w/"+json["weather"][0]["icon"].string!+".png")!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)!)!
        maxTemp = NSString(format: "%.1f", json["main"]["temp_max"].doubleValue - 273.15) as! String
        minTemp = NSString(format: "%.1f", json["main"]["temp_min"].doubleValue - 273.15) as! String
        
        //３時間ごとの天気情報の取得
        request = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=Kikonai,jp&APPID=929cccb5476e5965410a401bf0efe12a")!)
        data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        json = JSON(data:data!)
        for (var i=0; i<6; i++) {
            forecastTemp.append((NSString(format: "%.0f", json["list"][i]["main"]["temp"].doubleValue) as String) + "℃" as String)
            forecastWeather.append(json["list"][i]["weather"][0]["main"].string!)
            forecastWeatherImage.append(UIImage(data: NSData(contentsOfURL: NSURL(string: "http://openweathermap.org/img/w/"+json["list"][i]["weather"][0]["icon"].string!+".png")!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)!)!)
            forecastTime.append(json["list"][i]["dt_txt"].string!)
        }
        
        //この先１週間の天気予報の取得
        request = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?cnt=8&q=Kikonai,jp&APPID=929cccb5476e5965410a401bf0efe12a")!)
        data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        json = JSON(data:data!)
        for (var i=1; i<=7; i++) {
            weeklyMaxTemp.append(NSString(format: "%.1f", json["list"][i]["temp"]["max"].doubleValue - 273.15) as! String)
            weeklyMinTemp.append(NSString(format: "%.1f", json["list"][i]["temp"]["min"].doubleValue - 273.15) as! String)
            weeklyWeather.append(json["list"][i]["weather"][0]["main"].string!)
            weeklyWeatherImage.append(UIImage(data: NSData(contentsOfURL: NSURL(string: "http://openweathermap.org/img/w/"+json["list"][i]["weather"][0]["icon"].string!+".png")!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)!)!)
        }
    }
}
