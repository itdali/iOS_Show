//
//  DLTableViewCell.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/22.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellText: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
