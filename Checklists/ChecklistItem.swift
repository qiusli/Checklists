//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Qiushi Li on 11/29/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import Foundation
class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeObjectForKey("Checked") as! Bool
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func toggle() {
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeObject(checked, forKey: "Checked")
    }
}