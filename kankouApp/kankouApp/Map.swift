//
//  tourmap.swift
//  kankouApp
//
//  Created by 山川拓也 on 2015/06/20.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit
import MapKit

class Map: UIViewController,MKMapViewDelegate ,CLLocationManagerDelegate{
    

    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var WalkTime: UILabel!
    @IBOutlet weak var DriveTime: UILabel!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    //現在地に関する変数
    var myLocationManager: CLLocationManager!
    
    
    //目的地の座標
    var requestLatitude = 0.0
    var requestLongitude = 0.0
    
    //出発点の座標
    var myLatitude: CLLocationDegrees = 0.0
    var myLongitude: CLLocationDegrees = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Distance.text = ""
        WalkTime.text = ""
        DriveTime.text = ""
        
        // 出発点の緯度、経度を設定. 今は仮に木古内駅にしている
        myLatitude = 41.677589
        myLongitude = 140.433941
        
        //目的地の緯度、経度を設定
        requestLatitude = 41.676253
        requestLongitude = 140.435481       //あおき
        
       // requestLatitude = 41.841835
       // requestLongitude = 140.766998     //未来大学
        
        // Delegateを設定.
        myMapView.delegate = self
        
        
        /*現在位置*/
        var region:MKCoordinateRegion = self.myMapView!.region
        self.myMapView!.setRegion(region, animated: true)
        myLocationManager = CLLocationManager()
        //位置情報を取得した時の通知先を指定
        myLocationManager.delegate = self
        //位置情報を更新する距離を指定
        myLocationManager.distanceFilter = kCLHeadingFilterNone
        //精度を100mの精度に指定
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        myLocationManager.startUpdatingLocation()
        
        var StorePin: MKPointAnnotation = MKPointAnnotation()
        StorePin.coordinate = CLLocationCoordinate2DMake(requestLatitude, requestLongitude)
        StorePin.title = "目的地のタイトル"
        StorePin.subtitle = "目的地のサブタイトル"
        myMapView.addAnnotation(StorePin)
        
        var overlays = myMapView.overlays
        myMapView.removeOverlays(overlays)
        caliculate()
        showUserAndDestinationOnMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //吹き出しの表示などの設定
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) ->MKAnnotationView!{
        //現在地をピンではなく青いまるにする
        if(annotation === myMapView.userLocation){
            return nil
        }
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
    
    // ルートの表示設定.
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let route: MKPolyline = overlay as! MKPolyline
        let routeRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: route)
        // ルートの線の太さ.
        routeRenderer.lineWidth = 3.0
        // ルートの線の色.
        routeRenderer.strokeColor = UIColor.redColor()
        return routeRenderer
    }
    
    // 地図の表示範囲を計算
    func showUserAndDestinationOnMap()
    {
        // 現在地と目的地を含む矩形を計算
        var maxLat:Double = fmax(myLatitude,  requestLatitude)
        var maxLon:Double = fmax(myLongitude, requestLongitude)
        var minLat:Double = fmin(myLatitude,  requestLatitude)
        var minLon:Double = fmin(myLongitude, requestLongitude)
        
        // 地図表示するときの緯度、経度の幅を計算
        var mapMargin:Double = 1.5;  // 経路が入る幅(1.0)＋余白(0.5)
        var leastCoordSpan:Double = 0.0038;    // 拡大表示したときの最大値
        var span_x:Double = fmax(leastCoordSpan, fabs(maxLat - minLat) * mapMargin);
        var span_y:Double = fmax(leastCoordSpan, fabs(maxLon - minLon) * mapMargin);
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(span_x, span_y);
        
        // 現在地を目的地の中心を計算
        var center:CLLocationCoordinate2D = CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
        var region:MKCoordinateRegion = MKCoordinateRegionMake(center, span);
        
        myMapView.setRegion(myMapView.regionThatFits(region), animated:true);
        
    }
    
    //ルート計算関数
    func caliculate() ->Void{
        // 目的地の座標を指定.
        var requestCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(requestLatitude, requestLongitude)
        let fromCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        
        // viewにmapViewを追加.
        self.view.addSubview(myMapView)
        // PlaceMarkを生成して出発点、目的地の座標をセット.
        let fromPlace: MKPlacemark = MKPlacemark(coordinate: fromCoordinate, addressDictionary: nil)
        let toPlace: MKPlacemark = MKPlacemark(coordinate: requestCoordinate, addressDictionary: nil)
        // Itemを生成してPlaceMarkをセット.
        let fromItem: MKMapItem = MKMapItem(placemark: fromPlace)
        let toItem: MKMapItem = MKMapItem(placemark: toPlace)
        // MKDirectionsRequestを生成.
        let myRequest_walk: MKDirectionsRequest = MKDirectionsRequest()
        let myRequest_drive: MKDirectionsRequest = MKDirectionsRequest()

        // 出発地のItemをセット.
        myRequest_walk.setSource(fromItem)
        myRequest_drive.setSource(fromItem)

        // 目的地のItemをセット.
        myRequest_walk.setDestination(toItem)
        myRequest_drive.setDestination(toItem)
        
        // 複数経路の検索を有効.
        myRequest_walk.requestsAlternateRoutes = true
        myRequest_drive.requestsAlternateRoutes = true

        // 移動手段を設定.
        myRequest_walk.transportType = MKDirectionsTransportType.Walking
        myRequest_drive.transportType = MKDirectionsTransportType.Automobile

        // MKDirectionsを生成してRequestをセット.
        let myDirections_walk: MKDirections = MKDirections(request: myRequest_walk)
        let myDirections_drive: MKDirections = MKDirections(request: myRequest_drive)

        // 経路探索.
        myDirections_walk.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse!, error: NSError!) -> Void in
            // NSErrorを受け取ったか、ルートがない場合.
            if error != nil || response.routes.isEmpty {
                return
            }
            let route: MKRoute = response.routes[0] as! MKRoute
            
            if route.distance < 1000{
                self.Distance.text = "目的地までの距離: \(route.distance)m"
            }else{
                self.Distance.text = "目的地までの距離: \(route.distance/1000)km"

            }
            
            self.WalkTime.text = "\(Int(route.expectedTravelTime/60))分"
            
            // mapViewにルートを描画.
            self.myMapView.addOverlay(route.polyline)
        }
        
        myDirections_drive.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse!, error: NSError!) -> Void in
            // NSErrorを受け取ったか、ルートがない場合.
            if error != nil || response.routes.isEmpty {
                return
            }
            let route: MKRoute = response.routes[0] as! MKRoute
            
            self.DriveTime.text = "\(Int(route.expectedTravelTime/60))分"
            
            
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
