//
//  MultiMediaController.swift
//  iOS_Show
//
//  Created by dali on 2016/12/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class MultiMediaController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imgView: UIImageView!
    var imgPickerController: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllUI()
    }
    
    func loadAllUI() {
        
        // init imgView
        imgView = UIImageView()
        imgView.layer.borderWidth = 0.5
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(imgView)
        
        imgView.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.center.equalTo(view)
        }
        
        // init imgPickerController
        imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        imgPickerController.allowsEditing = true
    }

    @IBAction func PhotoLibraryAndCamera(){
        DLprint("")
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "相册选取", style: .default){
            (action) -> Void in
            self.getImage(type: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "拍照", style: .default){
            (action) -> Void in
            self.getImage(type: .camera)
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancleAction)
        present(alertController, animated: true, completion: nil)
    }
    func getImage(type: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type) {
            imgPickerController.sourceType = type
            present(imgPickerController, animated: true, completion: nil)
        } else{
            DLprint("此设备暂不支持")
        }
    }
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let type: String = info[UIImagePickerControllerMediaType] as! String
        DLprint(type)
        if type == "public.image" {
            let img = info[UIImagePickerControllerOriginalImage] as? UIImage
            imgView.image = img
            // 压缩图片
            _ = UIImageJPEGRepresentation(img!, 0.5)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
