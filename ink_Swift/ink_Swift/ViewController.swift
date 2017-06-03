//
//  ViewController.swift
//  ink_Swift
//
//  Created by 李砚 on 2017/6/3.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var index: NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PRAGMA: actions
    
    @IBAction func showBadgeHandelr(_ sender: AnyObject) {
        index += 1
        self.tabBarItem.badgeValue = "\(index)"
    }
    
    @IBAction func hideBadgeHandler(_ sender: AnyObject) {
        self.tabBarItem.badgeValue = nil
    }


}

