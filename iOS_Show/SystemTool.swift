//
//  SystemTool.swift
//  iOS_Show
//
//  Created by dali on 27/03/2017.
//  Copyright © 2017 dali. All rights reserved.
//

import UIKit

class SystemTool: NSObject {
    
    
    /// 当前日式和时间
    ///
    /// - Parameter dataFormat: 日期格式，例如：yyyyMMddHHmmss
    /// - Returns: 日期串
    internal class func currentDate(_ dataFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dataFormat
        return dateFormatter.string(from: Date())
    }

}
