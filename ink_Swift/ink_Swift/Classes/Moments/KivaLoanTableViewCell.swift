//
//  KivaLoanTableViewCell.swift
//  ink_Swift
//
//  Created by liyan on 2017/6/26.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var countryLabel:UILabel!
    @IBOutlet weak var useLabel:UILabel!
    @IBOutlet weak var amountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
