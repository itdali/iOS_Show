//
//  DLCollectionViewCell.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/19.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

public protocol DLCollectionViewCellDelegate: NSObjectProtocol {
    func collectionViewCell(collectionViewCell cell:UICollectionViewCell, deleteButton button: UIButton, atIndexPath indexPath: IndexPath)
}

class DLCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DLCollectionViewCellDelegate!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var indexPath: IndexPath!
    
    var enableEdit: Bool = false {
        willSet {
            DLprint("")
        }
        didSet {
            DLprint("")
            deleteButton.isHidden = !enableEdit
            enableEdit ? startAnimation() : stopAnimation()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = deleteButton.frame.size.height*0.5
        deleteButton.isHidden = !enableEdit
    }

    @IBAction func deleteButtonClick() {
        if delegate != nil {
            delegate.collectionViewCell(collectionViewCell: self, deleteButton: deleteButton, atIndexPath: indexPath)
        }
    }
    
    func startAnimation() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        shakeAnimation.fromValue = NSNumber(value: -0.01*Double.pi as Double)
        shakeAnimation.toValue = NSNumber(value: 0.01*Double.pi as Double)
        shakeAnimation.autoreverses = true
        //shakeAnimation.fillMode = kCAFillModeForwards
        //shakeAnimation.removedOnCompletion = false
        shakeAnimation.repeatCount = MAXFLOAT
        shakeAnimation.duration = 0.1 + 0.01*Double((arc4random()%2)+1)
        //shakeAnimation.duration = 0.1 + 0.01*Double((random()%2)+1)
        
        self.layer.add(shakeAnimation, forKey: "shakeAnimation")
    }
    func stopAnimation() {
        self.layer.removeAllAnimations()
    }

}
