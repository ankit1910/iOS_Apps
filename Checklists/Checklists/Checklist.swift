//
//  Checklist.swift
//  Checklists
//
//  Created by Ankit on 03/04/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit


class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [ChecklistItem]()
    var iconName: String
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObjectForKey("IconName") as! String
        super.init()
    }
    
    init(name: String) {
        self.name = name
        self.iconName = "No Icon"
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "IconName")
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
    
}
