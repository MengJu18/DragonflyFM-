//
//  VMChannels.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class VMChannels:JSONable {
    required init(json: Dictionary<String, Any>) {
        audienceCount = json[json_channels_audienceCount] as? Int32
        if json[json_channels_categories] is NSArray {
            let categorie = json[json_channels_categories] as! NSArray
            for a in categorie {
                let c = a as! Dictionary<String,Any>
                categories = (c["title"]) as? String
            }
        }
        contentId = json[json_channels_contentId] as? Int32
        cover = json[json_channels_cover] as? String
        descriptions = json[json_channels_descriptions] as? String
        title = json[json_channels_title] as? String
        updateTime = json[json_channels_updateTime] as? String
        if json[json_channels_nowplaying] is NSObject {
            let now = json[json_channels_nowplaying] as! Dictionary<String,Any>
            nowplaying = now["title"] as? String
           
        }
        
    }
    
    var audienceCount:Int32?
    var categories:String?
    var contentId: Int32?
    var cover: String?
    var descriptions: String?
    var nowplaying: String?
    var title: String?
    var updateTime: String?
    
    static let entityName = "Channels"
    static let colAudienceCount = "audienceCount"
    static let colCategories = "categories"
    static let colContentId = "contentId"
    static let colCover = "cover"
    static let colDescriptions = "descriptions"
    static let colNowplaying = "nowplaying"
    static let colTitle = "title"
    static let colUpdateTime = "updateTime"
}
