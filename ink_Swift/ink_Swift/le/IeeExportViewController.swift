//
//  IeeExportViewController.swift
//  ink_Swift
//
//  Created by 李砚 on 2017/6/3.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class IeeExportViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    fileprivate let itemDataSouce: [[(name: String, iconImage: UIImage)]] = [
        [
            ("Spring", TSAsset.Ff_IconShowAlbum.image),
            ],
        [
            ("扫一扫", TSAsset.Ff_IconQRCode.image),
            ("摇一摇", TSAsset.Ff_IconShake.image),
            ],
        [
            ("附近的人", TSAsset.Ff_IconLocationService.image),
            ("漂流瓶", TSAsset.Ff_IconBottle.image),
            ],
        [
            //            ("购物", TSAsset.Icon_bustime.image),
            ("游戏", TSAsset.MoreGame.image),
            ],
        ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ink"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(TSImageTextTableViewCell.self)
        self.listTableView.estimatedRowHeight = 44
        self.listTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        log.verbose("deinit")
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

// MARK: @protocol - UITableViewDelegate
extension IeeExportViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)")
        if indexPath.section == 0 && indexPath.row == 0 {
//            let sb = UIStoryboard(name: "Spring", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "SpringViewController") as! SpringViewController
//            self.navigationController!.pushViewController(vc, animated: true)

        }
        if indexPath.section == 1 && indexPath.row == 0 {
            
            let vc = ViewController.ts_initFromNib()
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    
}

// MARK: @protocol - UITableViewDataSource
extension IeeExportViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.itemDataSouce[section]
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.listTableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :TSImageTextTableViewCell = tableView.ts_dequeueReusableCell(TSImageTextTableViewCell.self)
        let item = self.itemDataSouce[indexPath.section][indexPath.row]
        cell.iconImageView.image = item.iconImage
        cell.titleLabel.text = item.name
        return cell
    }
}



 
