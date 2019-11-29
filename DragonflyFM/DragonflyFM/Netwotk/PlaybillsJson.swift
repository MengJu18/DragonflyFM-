//
//  PlaybillsJson.swift
//  DragonflyFM
//
//  Created by ChenChaoXiu on 2019/11/20.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let json_playbills_starTime = "start_time"
let json_playbills_endTime = "end_time"
let json_playbills_duration = "duration"
let json_playbills_title = "title"
let json_playbills_username = "username"
let json_playbills_broadcasters = "broadcasters"
let json_playbills_channelId = "channel_id"
class PlaybillsJson {
    static func getSearchUrl(id:Int32) -> String{
        let url = "https://rapi.qingting.fm/v2/channels/"+"\(id)"+"/playbills?day=1,2,3,4,5,6,7"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}

