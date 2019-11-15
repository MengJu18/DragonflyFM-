//
//  ChannelsJson.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let json_channels_audienceCount = "audience_count"
let json_channels_categories = "categories"
let json_channels_contentId = "content_id"
let json_channels_cover = "cover"
let json_channels_descriptions = "description"
let json_channels_nowplaying = "nowplaying"
let json_channels_title = "title"
let json_channels_updateTime = "update_time"
let json_channels_items = "items"

class ChannelsJson {
    static func getSearchUrl(id:Int32,page:Int) -> String{
        let url = "https://rapi.qingting.fm/categories/\(id)/channels?with_total=true&page=\(page)&pagesize=21"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
