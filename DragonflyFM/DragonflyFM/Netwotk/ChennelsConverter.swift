//
//  ChennelsConverter.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/15.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class ChennelsConverter {
    static func getChennels(json:Any) -> [VMChannels]? {
        var chennels:[VMChannels]?
        let dic = json as! Dictionary<String,Any>
        if dic.count > 0 {
            chennels = JSONConverter<VMChannels>.getArray(json: json, key: json_channels_items)
        }
        return chennels
    }
    static func getChennel(json:Any) -> [VMChannels]? {
        var chennels:[VMChannels]?
        let dic = json as! Dictionary<String,Any>
        if dic.count > 0 {
            chennels = JSONConverter<VMChannels>.getArrayKey(json: json, key: json_channels_docs)
        }
        return chennels
    }
}
