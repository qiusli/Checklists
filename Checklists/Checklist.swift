//
//  Checlist.swift
//  Checklists
//
//  Created by Qiushi Li on 11/30/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    init(name: String) {
        self.name = name
        super.init()
    }
}
