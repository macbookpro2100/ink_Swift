//
//  ArticleTableViewController.swift
//  ink_Swift
//
//  Created by liyan on 2017/6/26.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    let postTitles = ["Use Background Transfer Service To Download File in Background",
                      "Face Detection in iOS Using Core Image",
                      "Building a Speech-to-Text App Using Speech Framework in iOS 10",
                      "Building Your First Web App in Swift Using Vapor",
                      "Creating Gradient Colors Using CAGradientLayer",
                      "A Beginner's Guide to CALayer"]
    
    let postImages = ["imessage-sticker-pack", "face-detection-featured", "speech-kit-featured", "vapor-web-framework", "cagradientlayer-demo", "calayer-featured"]
    
    var postShown = [Bool](repeating: false, count: 6)
    
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
}
