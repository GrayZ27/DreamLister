//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Gray Zhen on 8/17/17.
//  Copyright © 2017 GrayStudio. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.dateCreated = NSDate()
        
    }
    
}
