//
//  UIImageViewController.swift
//  iOS_Show
//
//  Created by dali on 2017/3/12.
//  Copyright © 2017年 dali. All rights reserved.
//

import UIKit

class UIImageViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageCutBtn: UIButton!
    
    var imgView_1: UIImageView!
    var imgView_2: UIImageView!
    var imgView_3: UIImageView!
    var imgView_4: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadAllUI()
        imageCutBtn.addTarget(self, action: #selector(imageCutClick), for: .touchUpInside)
    }
    
    func loadAllUI() {
        imgView_1 = UIImageView()
        imgView_2 = UIImageView()
        imgView_3 = UIImageView()
        imgView_4 = UIImageView()
        imgView_1.contentMode = .scaleToFill
        imgView_2.contentMode = .scaleToFill
        imgView_3.contentMode = .scaleToFill
        imgView_4.contentMode = .scaleToFill
        view.addSubview(imgView_1)
        view.addSubview(imgView_2)
        view.addSubview(imgView_3)
        view.addSubview(imgView_4)
        
        
        
        let imgView_1_width: CGFloat = 100
        let imgView_1_height: CGFloat = 80
        imgView_1.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(imageView.snp.left).offset(-5)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: imgView_1_width, height: imgView_1_height))
        }
        imgView_2.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(imgView_1.snp.right).offset(10)
            make.right.equalTo(imageView.snp.right).offset(5)
            make.top.equalTo(imgView_1).offset(10)
            make.size.equalTo(CGSize(width: imageView.frame.width-imgView_1_width, height: imgView_1_height))
        }
        imgView_3.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(imgView_1).offset(-5)
            make.top.equalTo(imgView_1.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: imgView_1_width, height: imageView.frame.height-imgView_1_height))
        }
        imgView_4.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(imgView_3.snp.right).offset(10)
            make.right.equalTo(imgView_2)
            make.top.equalTo(imgView_3.snp.top).offset(15)
            make.height.equalTo(imgView_3.snp.height)
        }
        
    }
    
    
    func imageCutClick() {
        let image: UIImage = imageView.image!
        let cgImage:CGImage = image.cgImage!
        
        // 图片的实际尺寸
        let imageWidth: CGFloat = CGFloat(cgImage.width)
        let imageHeight: CGFloat = CGFloat(cgImage.height)
        
        // 根据要裁剪的尺寸占实际尺寸的比例确定数值
        let width_1:CGFloat = CGFloat((100/imageView.frame.width)*imageWidth)
        let height_1:CGFloat = CGFloat((80/imageView.frame.height)*imageHeight)
        
        // 设置裁剪尺寸，以图片为参考系
        let rect_1 = CGRect(x: 0, y: 0, width: width_1, height: height_1)
        let imageRef_1: CGImage = cgImage.cropping(to: rect_1)!
        let img_1: UIImage = UIImage(cgImage: imageRef_1, scale: image.scale, orientation: image.imageOrientation)
        imgView_1.image = img_1
        
        let rect_2 = CGRect(x: width_1, y: 0, width: imageWidth-width_1, height: height_1)
        let imageRef_2: CGImage = cgImage.cropping(to: rect_2)!
        let img_2: UIImage = UIImage(cgImage: imageRef_2, scale: image.scale, orientation: image.imageOrientation)
        imgView_2.image = img_2
        
        let rect_3 = CGRect(x: 0, y: height_1, width: width_1, height: imageHeight-height_1)
        let imageRef_3: CGImage = cgImage.cropping(to: rect_3)!
        let img_3: UIImage = UIImage(cgImage: imageRef_3, scale: image.scale, orientation: image.imageOrientation)
        imgView_3.image = img_3
        
        let rect_4 = CGRect(x: width_1, y: height_1, width: imageWidth-width_1, height: imageHeight-height_1)
        let imageRef_4: CGImage = cgImage.cropping(to: rect_4)!
        let img_4: UIImage = UIImage(cgImage: imageRef_4, scale: image.scale, orientation: image.imageOrientation)
        imgView_4.image = img_4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
