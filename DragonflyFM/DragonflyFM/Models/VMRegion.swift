//
//  VMRegion.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class VMRegion: JSONable {
    required init(json: Dictionary<String, Any>) {
        region = json[json_data_region] as? String
    }
    
    var region: String?
    
    static let entityName = "Region"
    static let colRegion = "region"
}
