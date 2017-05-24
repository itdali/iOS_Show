//
//  DLScrollViewCell.swift
//  iOS_Show
//
//  Created by dali on 16/10/14.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLScrollViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
