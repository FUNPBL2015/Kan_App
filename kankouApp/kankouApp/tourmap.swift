//
//  tourmap.swift
//  kankouApp
//
//  Created by 山川拓也 on 2015/06/20.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit
import MapKit

class tourmap: UIViewController,MKMapViewDelegate{

    @IBOutlet weak var myMapView: MKMapView!
    
    class Pin : MKPointAnnotation{
        var x = 0.0
        var y = 0.0
        var WebURL: String!
    }
    
    var PinArrayBuy: Array<Pin> = []               //ピンのオブジェクト格納
    var PinArrayLook: Array<Pin> = []
    var PinArrayEat: Array<Pin> = []
    var DataArray = [[String]]()
    
    //計算時の行き先座標
    var requestLatitude = 0.0
    var requestLongitude = 0.0
    
    //計算時の行き先の座標
    var myLatitude: CLLocationDegrees = 0.0
    var myLongitude: CLLocationDegrees = 0.0
    
    func csvsplit(filename: String){
        var path = NSBundle.mainBundle().pathForResource(filename, ofType: "csv")
        var data = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil) as!String
        
        let lines = split(data, isSeparator: { $0 == "\n"})
        for line in lines{
            DataArray.append(split(line, isSeparator: { $0 == ","}))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvsplit("PinBuy")
        /*「買う」に関するピン情報を格納*/
        for(var i = 0; i < DataArray.count; i++){
            
            PinArrayBuy.append(Pin())
            PinArrayBuy[i].x = atof(DataArray[i][0])
            PinArrayBuy[i].y = atof(DataArray[i][1])
            PinArrayBuy[i].coordinate = CLLocationCoordinate2DMake(PinArrayBuy[i].x, PinArrayBuy[i].y)
            PinArrayBuy[i].title = DataArray[i][2]
            PinArrayBuy[i].subtitle = DataArray[i][3]
            PinArrayBuy[i].WebURL = DataArray[i][4]
        }
        
        csvsplit("PinLook")
        /*「見る・遊ぶ」に関するピン情報を格納*/
        for(var i = 0; i < DataArray.count; i++){
            
            PinArrayLook.append(Pin())
            PinArrayLook[i].x = atof(DataArray[i][0])
            PinArrayLook[i].y = atof(DataArray[i][1])
            PinArrayLook[i].coordinate = CLLocationCoordinate2DMake(PinArrayLook[i].x, PinArrayLook[i].y)
            PinArrayLook[i].title = DataArray[i][2]
            PinArrayLook[i].subtitle = DataArray[i][3]
            PinArrayLook[i].WebURL = DataArray[i][4]
        }
        
        
        csvsplit("PinEat")
        /*「買う」に関するピン情報を格納*/
        for(var i = 0; i < DataArray.count; i++){
            
            PinArrayEat.append(Pin())
            PinArrayEat[i].x = atof(DataArray[i][0])
            PinArrayEat[i].y = atof(DataArray[i][1])
            PinArrayEat[i].coordinate = CLLocationCoordinate2DMake(PinArrayEat[i].x, PinArrayEat[i].y)
            PinArrayEat[i].title = DataArray[i][2]
            PinArrayEat[i].subtitle = DataArray[i][3]
            PinArrayEat[i].WebURL = DataArray[i][4]
        }
        
        // 出発点の緯度、経度を設定.
        myLatitude = 41.677589
        myLongitude = 140.433941
        
        // Delegateを設定.
        myMapView.delegate = self
        
        
        //pin3を目的地の座標に設定
        requestLatitude = myLatitude
        requestLongitude = myLongitude
        
        caliculate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //グルメをタップした時の動作
    @IBAction func EatTapButton(sender: AnyObject) {
        removeallannotations()
        myMapView.addAnnotations(PinArrayEat)
    }

    
    //観光をタップした時の動作
    @IBAction func LookTapButton(sender: AnyObject) {
        removeallannotations()
        myMapView.addAnnotations(PinArrayLook)
    }

    
    //お土産をタップした時の動作
    @IBAction func BuyTapButton(sender: AnyObject) {
        removeallannotations()
        myMapView.addAnnotations(PinArrayBuy)
    }

    func removeallannotations(){
        myMapView.removeAnnotations(PinArrayBuy)
        myMapView.removeAnnotations(PinArrayEat)
        myMapView.removeAnnotations(PinArrayLook)
    }
    
    //吹き出しの表示などの設定
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) ->MKAnnotationView!{
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            var rightButton: AnyObject! = UIButton.buttonWithType(UIButtonType.DetailDisclosure)
            pinView!.rightCalloutAccessoryView = rightButton as! UIView
            
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    //選択画面設定
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        var allID = 0
        var nowID = 0
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        let alertController = UIAlertController(title: "", message: "選択してください", preferredStyle: .ActionSheet)
        //詳細情報表示の処理
        let firstAction = UIAlertAction(title: "詳細情報表示", style: .Default) {
            action in
            
            //「買う」に関する詳細情報
            for(var i=0;i<self.PinArrayBuy.count;i++){
                allID = self.PinArrayBuy[i].hash
                nowID = view.annotation.hash
                if(allID==nowID){
                    appDelegate.PinURL = self.PinArrayBuy[i].WebURL //appDelegateの変数を操作
                    var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("WebPage")
                    self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
                    break
                }
            }
            
            //「見る・遊ぶ」に関する詳細情報
            for(var i=0;i<self.PinArrayLook.count;i++){
                allID = self.PinArrayLook[i].hash
                nowID = view.annotation.hash
                if(allID==nowID){
                    appDelegate.PinURL = self.PinArrayLook[i].WebURL //appDelegateの変数を操作
                    var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("WebPage")
                    self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
                    break
                }
            }
            
            //「食べる」に関する詳細情報
            for(var i=0;i<self.PinArrayEat.count;i++){
                allID = self.PinArrayEat[i].hash
                nowID = view.annotation.hash
                if(allID==nowID){
                    appDelegate.PinURL = self.PinArrayEat[i].WebURL //appDelegateの変数を操作
                    var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("WebPage")
                    self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
                    break
                }
            }
            
            
        }
        //ルート表示の処理
        let secondAction = UIAlertAction(title: "ルート案内", style: .Default) {
            action in
            //ルートを消す
            var overlays = mapView.overlays
            mapView.removeOverlays(overlays)
            //行き先を設定する
            for(var i=0;i<self.PinArrayBuy.count;i++){
                allID = self.PinArrayBuy[i].hash
                nowID = view.annotation.hash
                if(allID==nowID){
                    self.requestLatitude = self.PinArrayBuy[i].x
                    self.requestLongitude = self.PinArrayBuy[i].y
                    break
                }
            }
            
            for(var i=0;i<self.PinArrayLook.count;i++){
                allID = self.PinArrayLook[i].hash
                nowID = view.annotation.hash
                if(allID==nowID){
                    self.requestLatitude = self.PinArrayLook[i].x
                    self.requestLongitude = self.PinArrayLook[i].y
                    break
                }
            }
            
            
            for(var i=0;i<self.PinArrayEat.count;i++){
                allID = self.PinArrayEat[i].hash
                nowID = view.annotation.hash
                if(allID==nowID){
                    self.requestLatitude = self.PinArrayEat[i].x
                    self.requestLongitude = self.PinArrayEat[i].y
                    break
                }
            }
            
            //設定した行き先で計算
            self.caliculate()
        }
        //キャンセル時の処理
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel) {
            action in println("Pushed CANCEL")
        }
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // ルートの表示設定.
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let route: MKPolyline = overlay as! MKPolyline
        let routeRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: route)
        // ルートの線の太さ.
        routeRenderer.lineWidth = 5.0
        // ルートの線の色.
        routeRenderer.strokeColor = UIColor.redColor()
        return routeRenderer
    }
    
    //ルート計算関数
    func caliculate() ->Void{
        // 目的地の座標を指定.
        var requestCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(requestLatitude, requestLongitude)
        
        let fromCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        // 地図の中心を出発点と目的地の中間に設定する.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake((myLatitude + requestLatitude)/2, (myLongitude + requestLongitude)/2)
        // mapViewに中心をセットする.
        myMapView.setCenterCoordinate(center, animated: true)
        // 縮尺を指定.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        // regionをmapViewにセット.
        myMapView.region = myRegion
        // viewにmapViewを追加.
        self.view.addSubview(myMapView)
        // PlaceMarkを生成して出発点、目的地の座標をセット.
        let fromPlace: MKPlacemark = MKPlacemark(coordinate: fromCoordinate, addressDictionary: nil)
        let toPlace: MKPlacemark = MKPlacemark(coordinate: requestCoordinate, addressDictionary: nil)
        // Itemを生成してPlaceMarkをセット.
        let fromItem: MKMapItem = MKMapItem(placemark: fromPlace)
        let toItem: MKMapItem = MKMapItem(placemark: toPlace)
        // MKDirectionsRequestを生成.
        let myRequest: MKDirectionsRequest = MKDirectionsRequest()
        // 出発地のItemをセット.
        myRequest.setSource(fromItem)
        // 目的地のItemをセット.
        myRequest.setDestination(toItem)
        // 複数経路の検索を有効.
        myRequest.requestsAlternateRoutes = true
        // 移動手段を歩きに設定.
        myRequest.transportType = MKDirectionsTransportType.Walking
        // MKDirectionsを生成してRequestをセット.
        let myDirections: MKDirections = MKDirections(request: myRequest)
        // 経路探索.
        myDirections.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse!, error: NSError!) -> Void in
            // NSErrorを受け取ったか、ルートがない場合.
            if error != nil || response.routes.isEmpty {
                return
            }
            let route: MKRoute = response.routes[0] as! MKRoute
            
            // println("目的地まで \(route.distance)km")
            // println("所要時間 \(Int(route.expectedTravelTime/60))分")
            // mapViewにルートを描画.
            self.myMapView.addOverlay(route.polyline)
        }
        
    }
    //位置更新がされた時のメソッド
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations:[AnyObject]!) {
        //ユーザの現在地を表示する
        myMapView.showsUserLocation = true
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
