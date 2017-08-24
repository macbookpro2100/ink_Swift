//
//  TSDiscoverViewController.swift
//  TSWeChat
//
//  Created by Hilen on 1/8/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import UIKit

class TSAppCodaViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    fileprivate let itemDataSouce: [[(name: String, iconImage: UIImage)]] = [
        [
            ("AnimalTableViewController", TSAsset.Ff_IconShowAlbum.image),
            ("ArticleTableViewController", TSAsset.Ff_IconQRCode.image),
            ("KivaLoanTableViewController", TSAsset.Ff_IconShake.image),
            ("XML", TSAsset.Ff_IconLocationService.image),
            ("漂流瓶", TSAsset.Ff_IconBottle.image),
            ("游戏", TSAsset.MoreGame.image),
            
        ],
       
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AppCoda"
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
extension TSAppCodaViewController: UITableViewDelegate {
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
        tableView.deselectRow(at: indexPath, animated: true)
        let selectindex = indexPath.row
        switch selectindex {
        case 0:
            let vc = AnimalTableViewController.init(style: UITableViewStyle.grouped)
            self.ts_nav_pushView(vc)
            break;
        case 1:
            let vc = ArticleTableViewController.init(style: UITableViewStyle.grouped)
            self.ts_nav_pushView(vc)
            break;
        case 2:
            let vc = KivaLoanTableViewController.init(style: UITableViewStyle.plain)
            self.ts_nav_pushView(vc)
            
 
            break;
        case 3:
            
            
            let vc = XmlTableViewController.init()
            self.ts_nav_pushView(vc)
 
            break;
        case 4:
 
            break;
        case 5:
 
            break;
        default:
            break;
        }
    }
}

// MARK: @protocol - UITableViewDataSource
extension TSAppCodaViewController: UITableViewDataSource {
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



