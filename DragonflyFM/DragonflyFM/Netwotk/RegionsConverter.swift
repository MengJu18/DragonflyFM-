//
//  RegionsConverter.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/15.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class RegionsConverter {
    static func getRegions(json:Any) -> [VMRegions]? {
        var chennels:[VMRegions]?
        let dic = json as! Dictionary<String,Any>
        if dic.count > 0 {
            chennels = JSONConverter<VMRegions>.getArrays(json: json, key: json_tag_Data)
        }
        return chennels
    }
}
