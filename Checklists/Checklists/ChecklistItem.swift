//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Ankit on 01/04/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit


class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func toggleChecked() {
        self.checked = !self.checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
}
