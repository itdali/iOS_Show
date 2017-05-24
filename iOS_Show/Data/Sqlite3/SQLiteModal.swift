//
//  SQLiteModal.swift
//  iOS_Show
//
//  Created by dali on 2016/12/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class SQLiteModal: NSObject {
    var id: Int!
    var name: String = ""
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    override init() {
        super.init()
    }
}
