//
//  Article2TableViewCell.swift
//  ink_Swift
//
//  Created by liyan on 2017/6/26.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class Article2TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var postImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
