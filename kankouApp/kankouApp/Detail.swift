//
//  Detail.swift
//  kankouApp
//
//  Created by 岩見建汰 on 2015/07/04.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit
import MapKit

class Detail: UIViewController,MKMapViewDelegate{

    @IBOutlet weak var StoreName: UILabel!
    @IBOutlet weak var StoreMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreName.text = "CEK倶楽部"
        StoreName.font = UIFont.systemFontOfSize(25)
        StoreName.textAlignment = NSTextAlignment.Center
        
        //Map関連
        self.StoreMap?.delegate = self
        
        var region: MKCoordinateRegion = self.StoreMap!.region
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.677589, 140.433941)
        region.center = location
        region.span.latitudeDelta = 0.005
        region.span.longitudeDelta = 0.005
        
        self.StoreMap!.setRegion(region, animated: true)
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
