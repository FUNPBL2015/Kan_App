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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
