//
//  Regions+CoreDataProperties.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
//

import Foundation
import CoreData


extension Regions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Regions> {
        return NSFetchRequest<Regions>(entityName: "Regions")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?

}
