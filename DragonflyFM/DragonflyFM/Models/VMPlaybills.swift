//
//  VMPlaybills.swift
//  DragonflyFM
//
//  Created by ChenChaoXiu on 2019/11/20.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class VMPlaybills:JSONable{
    
    required init(json: Dictionary<String, Any>) {
        starItme = json[json_playbills_starTime] as? String
        endTime = json[json_playbills_endTime] as? String
        duration = json[json_playbills_duration] as? Int32
        title = json[json_playbills_title] as? String
        channelId = json[json_playbills_channelId] as? Int32
        if json[json_playbills_broadcasters] is NSArray {
            let broadcasters = json[json_playbills_broadcasters] as? NSArray
            username = ""
            for a in broadcasters! {
                let c = a as! Dictionary<String,Any>
                let d = c[json_playbills_username]
                username?.append(d as! String + ",")
            }
            if username!.count > 0 {
                username?.removeLast()
            }
        }
    }

    var starItme:String?
    var endTime:String?
    var duration:Int32?
    var title:String?
    var channelId:Int32?
    var username:String?
    
    static let entityName = "Playbills"
    static let colStarTitme = "starTime"
    static let cloEndTime = "entTime"
    static let colDuration = "duration"
    static let colTitle = "title"
    static let colUsername = "username"
    static let colChannelId = "channelId"
}
