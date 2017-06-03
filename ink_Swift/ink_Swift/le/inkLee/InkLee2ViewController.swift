//
//  InkLee2ViewController.swift
//  ink_Swift
//
//  Created by 李砚 on 2017/6/3.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class InkLee2ViewController: UITableViewController {
        
    var cells : NSDictionary? // Global Variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.bundlePath
        let plistName:NSString = "Property List.plist"
        let finalPath:NSString = (path as NSString).appendingPathComponent(plistName as String) as NSString
        cells = NSDictionary(contentsOfFile:finalPath as String)
        
        self.tableView.ts_registerCellNib(TSImageTextTableViewCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        let cell :TSImageTextTableViewCell = tableView.ts_dequeueReusableCell(TSImageTextTableViewCell.self)
        
        let myCell: AnyObject = cells!.object(forKey: "cell\((indexPath as NSIndexPath).row)") as! NSDictionary
        
        cell.titleLabel.text = myCell.object(forKey: "title") as? String
        cell.iconImageView.image = UIImage(named: myCell.object(forKey: "image") as! String)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?  {
        return "TuxMania"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section:Int) -> String? {
        return "Get all the Tux"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
