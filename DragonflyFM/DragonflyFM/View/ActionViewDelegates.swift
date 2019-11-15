//
//  ActionViewDelegates.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/7.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
protocol ActionViewDelegates {
    var title: String {get}
    var value: Any {get}
}

protocol PickerItemSelectdeDelegates {
    func itemSelectde(index: Int)
}
