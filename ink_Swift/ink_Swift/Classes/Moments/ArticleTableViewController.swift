//
//  ArticleTableViewController.swift
//  ink_Swift
//
//  Created by liyan on 2017/6/26.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    var postTitles = ["Use Background Transfer Service To Download File in Background",
                      "Face Detection in iOS Using Core Image",
                      "Building a Speech-to-Text App Using Speech Framework in iOS 10",
                      "Building Your First Web App in Swift Using Vapor",
                      "Creating Gradient Colors Using CAGradientLayer",
                      "A Beginner's Guide to CALayer"]
    
    var postImages = ["imessage-sticker-pack", "face-detection-featured", "speech-kit-featured", "vapor-web-framework", "cagradientlayer-demo", "calayer-featured"]
    
    var postShown = [Bool](repeating: false, count: 6)
    var restaurantIsVisited = Array(repeating: false, count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.ts_registerCellNib(Article2TableViewCell.self)

        
        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postTitles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell :Article2TableViewCell = tableView.ts_dequeueReusableCell(Article2TableViewCell.self)
        
        // Configure the cell...
        cell.titleLabel.text = postTitles[(indexPath as NSIndexPath).row]
        cell.postImageView.image = UIImage(named: postImages[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    
    /* Uncomment to test the fade-in effect
     override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
     // Define the initial state (Before the animation)
     cell.alpha = 0
     
     // Define the final state (After the animation)
     UIView.animate(withDuration: 1.0, animations: { cell.alpha = 1 })
     }
     */
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Determine if the post is displayed. If yes, we just return and no animation will be created
        if postShown[indexPath.row] {
            return
        }
        
        // Indicate the post has been displayed, so the animation won't be displayed again
        postShown[indexPath.row] = true
        
        // Define the initial state (Before the animation)
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        
        // Define the final state (After the animation)
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
        }
        
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Check-in action
        // Determine the check in title. If the selected restaurant has been checked (i.e.
        // restaurantIsVisited[indexPath.row] returns true), the title will be set to "Undo Check in".
        let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            
            // Toggle check-in and undo-check-in
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        })
        optionMenu.addAction(checkInAction)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
    }
    
/// 编辑
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            postTitles.remove(at: indexPath.row)
            postImages.remove(at: indexPath.row)
            restaurantIsVisited.remove(at: indexPath.row)
            }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        print("Total item: \(postTitles.count)")
        for name in postImages {
            print(name)
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "Just checking in at " + self.postTitles[indexPath.row]
            
            if let imageToShare = UIImage(named: self.postImages[indexPath.row]) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        })
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            // Delete the row from the data source
            self.postTitles.remove(at: indexPath.row)
            self.postImages.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
 
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
}
