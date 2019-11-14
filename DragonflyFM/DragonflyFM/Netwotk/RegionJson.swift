//
//  RegionJson.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let json_data_region = "region"
class RegionJson{
    static func getSearchUrl() -> String{
        let url = "https://ip.qingting.fm/ip"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
