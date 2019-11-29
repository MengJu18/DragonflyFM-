//
//  PlaybillsConverter.swift
//  DragonflyFM
//
//  Created by ChenChaoXiu on 2019/11/20.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class PlaybillsConverter {
    static func getPlaybills(json:Any) -> [VMPlaybills]? {
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        let times = Date.getWeekDay(dateTime: strNowTime)
        var chennels:[VMPlaybills]?
        let dic = json as! Dictionary<String,Any>
        if dic.count > 0 {
            if times == 1 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "2")
            } else if times == 2 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "3")
            } else if times == 3 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "4")
            } else if times == 4 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "5")
            } else if times == 5 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "6")
            } else if times == 6 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "7")
            } else if times == 7 {
                chennels = JSONConverter<VMPlaybills>.getArraya(json: json, key: "1")
            }
        }
        return chennels
    }
    
}
