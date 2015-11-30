//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Qiushi Li on 11/29/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import Foundation
class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggle() {
        checked = !checked
    }
}