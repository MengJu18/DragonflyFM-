//
//  FamousQuotesConverter.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/17.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class FamousQuotesConverter {
    static func getFamousQuotes(json:Any) -> VMFamousQuotes? {
        var famousQuotes:VMFamousQuotes?
        let dic = json as! Dictionary<String,Any>
        if dic.count > 0 {
            famousQuotes = JSONConverter<VMFamousQuotes>.getSingle(json: json, key: json_famous_result)
        }
        return famousQuotes
    }
    
}
