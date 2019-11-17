//
//  FamousQuotes+CoreDataProperties.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/17.
//  Copyright © 2019年 2017yd. All rights reserved.
//
//

import Foundation
import CoreData


extension FamousQuotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FamousQuotes> {
        return NSFetchRequest<FamousQuotes>(entityName: "FamousQuotes")
    }

    @NSManaged public var name: String?
    @NSManaged public var saying: String?

}
