//
//  Detail.swift
//  kankouApp
//
//  Created by 岩見建汰 on 2015/07/04.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit

class Detail: UIViewController, UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var StoreLabel: UILabel!
    @IBOutlet weak var DetailTable: UITableView!
    @IBOutlet weak var DetailNavigationBar: UINavigationBar!
    
    var texts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StoreLabel.text = "CEK倶楽部"
        StoreLabel.font = UIFont.systemFontOfSize(20)
        DetailTable.delegate = self
        DetailTable.dataSource = self
        
        texts.append("電話番号：123-456-7899")
        texts.append("営業時間：10:00 〜 19:00")
        texts.append("定休日：月曜日")
        texts.append("駐車場：有(5台)")
        texts.append("開発者の独り言：ラーメンが美味い")

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
