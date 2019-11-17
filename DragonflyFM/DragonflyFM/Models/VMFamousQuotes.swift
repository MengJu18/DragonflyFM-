//
//  VMFamousQuotes.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/17.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
class VMFamousQuotes:JSONable {
    required init(json: Dictionary<String, Any>) {
//        name = json[]
    }
    
    var name:String?
    var saying:String?
    
    static let entityName = "FamousQuotes"
    static let colName = "name"
    static let colSaying = "saying"
}
