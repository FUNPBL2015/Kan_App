//
//  ViewController.swift
//  kankouApp
//
//  Created by 岩見建汰 on 2015/06/17.
//  Copyright (c) 2015年 Kenta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //アプリタイトル
    @IBOutlet var titleLabel: UIView!
    //観光スポット
    @IBOutlet weak var tourmapBtn: UIButton!
       //天気
    @IBOutlet weak var wetherBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.hidesBarsOnTap = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

