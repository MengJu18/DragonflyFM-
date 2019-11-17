//
//  FamousQuotesJson.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/17.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let json_famous_name = "famous_name"
let json_famous_saying = "famous_saying"
let json_famous_result = "result"

class FamousQuotesJson {
    static func getSearchUrl(id:Int32,page:Int) -> String{
        let url = "http://api.avatardata.cn/MingRenMingYan/Random?key=4feed2f1cc6646e79fd3acd952d4ed14"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
