//
//  c.swift
//  DragonflyFM
//
//  Created by ChenChaoXiu on 2019/11/19.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class VMRegions:JSONable {
    required init(json: Dictionary<String, Any>) {
        id = json[json_Data_id] as? Int32
        title = json[json_Data_title] as? String
    }
    var id:Int32?
    var title:String?
    
    static let entityName = "Regions"
    static let colId = "id"
    static let colTitle = "title"
}
