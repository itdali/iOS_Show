//
//  DLQRCodeVC.swift
//  iOS_Show
//
//  Created by dali on 16/11/1.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import AVFoundation

typealias Scale = (dx: CGFloat, dy: CGFloat)
class DLQRCodeVC: UIViewController {
    
    let readBtn: UIButton = UIButton()
    let createBtn: UIButton = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        loadAllUI()
    }

    func loadAllUI() {
        
        let backBtn: UIButton = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        view.addSubview(backBtn)
        
        readBtn.setTitle("读取", for: .normal)
        readBtn.setTitleColor(UIColor.blue, for: .normal)
        readBtn.addTarget(self, action: #selector(DLQRCodeVC.readClick), for: UIControlEvents.touchUpInside)
        view.addSubview(readBtn)
        
        createBtn.setTitle("生成", for: .normal)
        createBtn.setTitleColor(UIColor.blue, for: .normal)
        createBtn.addTarget(self, action: #selector(DLQRCodeVC.createClick), for: UIControlEvents.touchUpInside)
        view.addSubview(createBtn)
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(imageView)
        
        backBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 50, height: 30))
            make.top.left.equalTo(view).offset(20)
        }
        readBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 50, height: 30))
            make.top.left.equalTo(view).offset(50)
        }
        createBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(readBtn.snp.size)
            make.centerY.equalTo(readBtn.snp.centerY)
            make.right.equalTo(view.snp.right).offset(-50)
        }
        imageView.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.center.equalTo(view.center)
        }
    }
    
    func backClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupCamera(_ metadataTypes: [String]? = nil) {
        if supportsMetadataObjectTypes() {
            
        }
        else {
//            DLAlert().showAlert("提醒", subTitle: "Reader not supported by the current device", cancleBtnTitle: "OK", confirmBtnTitle: nil){
//                (button) -> Void in
//            }
        }
    }
    
    func supportsMetadataObjectTypes(_ metadataTypes: [String]? = nil) -> Bool {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return false }
        
        let output  = AVCaptureMetadataOutput()
        let session = AVCaptureSession()
        
        session.addInput(deviceInput)
        session.addOutput(output)
        
        var metadataObjectTypes = metadataTypes
        
        if metadataObjectTypes == nil || metadataObjectTypes?.count == 0 {
            // Check the QRCode metadata object type by default
            metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }
        
        for metadataObjectType in metadataObjectTypes! {
            if !output.availableMetadataObjectTypes.contains(where: { $0 as! String == metadataObjectType }) {
                return false
            }
        }
        return true
    }
    
    //MARK:- 读取二维码
    func readClick() {
        print(#function)
        setupCamera()
    }
    
    //MARK:- 生成二维码
    func createClick() {
        print(#function)
        //imageView.image = {image}()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    /// The QRCode's UIImage representation
    public var image: UIImage? {
        guard let ciImage = ciImage else { return nil }
        
        let size = CGSize(width: 200, height: 200)
        // Size
        let ciImageSize = ciImage.extent.size
        let widthRatio = size.width / ciImageSize.width
        let heightRatio = size.height / ciImageSize.height
        
        return ciImage.nonInterpolatedImage(withScale: Scale(dx: widthRatio, dy: heightRatio))
    }
    
    /// The QRCode's CIImage representation
    var ciImage: CIImage? {
        // Generate QRCode
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        let string = "12345"
        let data = string.data(using: .isoLatin1)
        
        qrFilter.setDefaults()
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        
        // Color code and background
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setDefaults()
        colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue(UIColor.black, forKey: "inputColor0")
        colorFilter.setValue(UIColor.orange, forKey: "inputColor1")
        
        return colorFilter.outputImage
    }*/
    
    
}

/*
extension CIImage {
    
    /// Creates an `UIImage` with interpolation disabled and scaled given a scale property
    ///
    /// - parameter withScale:  a given scale using to resize the result image
    ///
    /// - returns: an non-interpolated UIImage
    internal func nonInterpolatedImage(withScale scale: Scale = Scale(dx: 1, dy: 1)) -> UIImage? {
        guard let cgImage = CIContext(options: nil).createCGImage(self, from: self.extent) else { return nil }
        let size = CGSize(width: self.extent.size.width * scale.dx, height: self.extent.size.height * scale.dy)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: context.boundingBoxOfClipPath)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
extension CIColor {
    
    /// Creates a CIColor from an rgba string
    ///
    /// E.g.
    ///     `aaa`
    ///     `ff00`
    ///     `bb00ff`
    ///     `aabbccff`
    ///
    /// - parameter rgba:    The hex string to parse in rgba format
    public convenience init(rgba: String) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let scanner = Scanner(string: rgba)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexInt64(&hexValue) {
            let length = rgba.characters.count
            
            switch (length) {
            case 3:
                r = CGFloat((hexValue & 0xF00) >> 8)    / 15.0
                g = CGFloat((hexValue & 0x0F0) >> 4)    / 15.0
                b = CGFloat(hexValue & 0x00F)           / 15.0
            case 4:
                r = CGFloat((hexValue & 0xF000) >> 12)  / 15.0
                g = CGFloat((hexValue & 0x0F00) >> 8)   / 15.0
                b  = CGFloat((hexValue & 0x00F0) >> 4)  / 15.0
                a = CGFloat(hexValue & 0x000F)          / 15.0
            case 6:
                r = CGFloat((hexValue & 0xFF0000) >> 16)    / 255.0
                g = CGFloat((hexValue & 0x00FF00) >> 8)     / 255.0
                b  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                r = CGFloat((hexValue & 0xFF000000) >> 24)  / 255.0
                g = CGFloat((hexValue & 0x00FF0000) >> 16)  / 255.0
                b = CGFloat((hexValue & 0x0000FF00) >> 8)   / 255.0
                a = CGFloat(hexValue & 0x000000FF)          / 255.0
            default:
                print("Invalid number of values (\(length)) in HEX string. Make sure to enter 3, 4, 6 or 8 values. E.g. `aabbccff`")
            }
            
        } else {
            print("Invalid HEX value: \(rgba)")
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
}*/
