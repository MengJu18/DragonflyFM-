//
//  Playbills+CoreDataProperties.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/25.
//  Copyright © 2019年 2017yd. All rights reserved.
//
//

import Foundation
import CoreData


extension Playbills {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playbills> {
        return NSFetchRequest<Playbills>(entityName: "Playbills")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var endTime: String?
    @NSManaged public var startTime: String?
    @NSManaged public var title: String?
    @NSManaged public var username: String?
    @NSManaged public var channelId: Int32

}
