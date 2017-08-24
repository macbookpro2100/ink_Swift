//
//  SongCell.swift
//  ink_Swift
//
//  Created by liyan on 2017/8/21.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
