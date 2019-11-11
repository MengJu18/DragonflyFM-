//
//  JSONable.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/29.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
protocol JSONable {
    init(json: Dictionary<String, Any>)
}
