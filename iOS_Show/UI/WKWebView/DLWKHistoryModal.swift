//
//  DLWKHistoryModal.swift
//  iOS_Show
//
//  Created by dali on 27/03/2017.
//  Copyright © 2017 dali. All rights reserved.
//

import UIKit

// History Data Modal
class DLWKHistoryModal: NSObject {
    var id: Int!
    var title: String = ""
    var url: String = ""
    var date: String = ""
    
    init(id: Int, title: String, url: String, date: String){
        self.id = id
        self.title = title
        self.url = url
        self.date = date
    }
    override init() {
        super.init()
    }
}
