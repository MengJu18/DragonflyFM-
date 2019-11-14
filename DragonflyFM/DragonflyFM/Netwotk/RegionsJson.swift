//
//  RegionsJson.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let json_Data_id = "id"
let json_Data_title = "title"
class RegionsJson {
    static func getSearchUrl() -> String{
        let url = "https://rapi.qingting.fm/regions"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
