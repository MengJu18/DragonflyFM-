//
//  Channels+CoreDataProperties.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/25.
//  Copyright © 2019年 2017yd. All rights reserved.
//
//

import Foundation
import CoreData


extension Channels {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Channels> {
        return NSFetchRequest<Channels>(entityName: "Channels")
    }

    @NSManaged public var audienceCount: String?
    @NSManaged public var categories: String?
    @NSManaged public var contentId: Int32
    @NSManaged public var cover: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var id: UUID?
    @NSManaged public var nowplaying: String?
    @NSManaged public var title: String?
    @NSManaged public var updateTime: String?
    @NSManaged public var startTime: String?

}
