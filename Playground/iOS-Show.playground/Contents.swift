//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let nowDate = Date()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
let today = dateFormatter.string(from: nowDate)
if today > "2016-10-14" && today < "2016-10-17"{
    print(today)
}