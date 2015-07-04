//
//  Detail.swift
//  kankouApp
//
//  Created by 岩見建汰 on 2015/07/04.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit

class Detail: UIViewController, UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var StoreName: UILabel!
    @IBOutlet weak var DetailTable: UITableView!
    
    var texts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreName.text = "CEK倶楽部"
        StoreName.font = UIFont.systemFontOfSize(25)
        StoreName.textAlignment = NSTextAlignment.Center
        
        DetailTable.delegate = self
        DetailTable.dataSource = self
        
        texts.append("電話番号：123-456-7899")
        texts.append("営業時間：10:00 〜 19:00")
        texts.append("定休日：月曜日")
        texts.append("駐車場：有(5台)")
        texts.append("開発者の独り言：ラーメンが美味い")
//        //Map関連
//        self.StoreMap?.delegate = self
//        
//        var region: MKCoordinateRegion = self.StoreMap!.region
//        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.677589, 140.433941)
//        region.center = location
//        region.span.latitudeDelta = 0.005
//        region.span.longitudeDelta = 0.005
//        
//        self.StoreMap!.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
    
    // セルの選択を禁止する
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil;
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
