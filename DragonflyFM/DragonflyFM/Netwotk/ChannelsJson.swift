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
let json_channels_id = "id"
let json_channels_docs = "docs"

class ChannelsJson {
    static func getSearchUrl(id:Int32,page:Int) -> String{
        let url = "https://rapi.qingting.fm/categories/\(id)/channels?with_total=true&page=\(page)&pagesize=21"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    static func getStarSearchUrl(kw:String) -> String{
        let urlStr = "https://i.qingting.fm/wapi/search?k=" + kw + "&groups=channel_live"
        let url = urlStr.urlEncode()
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    
}
extension NSString {

    func urlEncode() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

