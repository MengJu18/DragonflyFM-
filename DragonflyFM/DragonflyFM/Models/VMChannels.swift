//
//  VMChannels.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class VMChannels:NSObject, JSONable,DataViewModilDelegate {
    func entityPairs() -> Dictionary<String, Any?> {
        var dic:Dictionary<String,Any?> = Dictionary<String,Any?>()
        dic[VMChannels.colId] = id
        dic[VMChannels.colAudienceCount] = audienceCount
        dic[VMChannels.colCategories] = categories
        dic[VMChannels.colContentId] = contentId
        dic[VMChannels.colCover] = cover
        dic[VMChannels.colDescriptions] = descriptions
         dic[VMChannels.colNowplaying] = nowplaying
         dic[VMChannels.colTitle] = title
         dic[VMChannels.colUpdateTime] = updateTime
        return dic
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let channels = result as! Channels
        audienceCount = channels.audienceCount
        categories = channels.categories
        contentId = channels.contentId
        cover = channels.cover
        descriptions = channels.descriptions
        nowplaying = channels.nowplaying
        title = channels.title
        updateTime = channels.updateTime
        id = channels.id!
    }
    
    
    required init(json: Dictionary<String, Any>) {
        id = UUID()
        audienceCount = String(describing: json[json_channels_audienceCount] as? Int32 )
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
    
    var audienceCount:String?
    var categories:String?
    var contentId: Int32?
    var cover: String?
    var descriptions: String?
    var nowplaying: String?
    var title: String?
    var updateTime: String?
    var id:UUID
    
    override init() {
        id = UUID()
    }
    
    static let entityName = "Channels"
    static let colAudienceCount = "audienceCount"
    static let colCategories = "categories"
    static let colContentId = "contentId"
    static let colCover = "cover"
    static let colDescriptions = "descriptions"
    static let colNowplaying = "nowplaying"
    static let colTitle = "title"
    static let colId = "id"
    static let colUpdateTime = "updateTime"
}
