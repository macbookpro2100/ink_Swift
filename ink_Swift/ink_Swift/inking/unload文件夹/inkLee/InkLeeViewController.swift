//
//  InkLeeViewController.swift
//  ink_Swift
//
//  Created by 李砚 on 2017/6/3.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class InkLeeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var cells : NSDictionary? // Global Variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.bundlePath
        let plistName:NSString = "Property List.plist"
        let finalPath:NSString = (path as NSString).appendingPathComponent(plistName as String) as NSString
        cells = NSDictionary(contentsOfFile:finalPath as String)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let myCell: AnyObject = cells!.object(forKey: "cell\((indexPath as NSIndexPath).row)") as! NSDictionary
        
        cell.myTitle?.text = myCell.object(forKey: "title") as? String
        cell.mySubtitle?.text = myCell.object(forKey: "subtitle") as? String
        cell.myImage?.image = UIImage(named: myCell.object(forKey: "image") as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?  {
        return "TuxMania"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section:Int) -> String? {
        return "Get all the Tux"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)")
        switch indexPath.row {
        case 1:
            break
            
        case 2 :
            
            break

        default:
            break
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
