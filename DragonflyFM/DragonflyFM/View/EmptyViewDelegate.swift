//
//  EmptyViewOelegate.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/24.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
import  UIKit
protocol EmptyViewDelegate {
    var isEmpty :Bool{get}
    func createEmptyView() ->UIView?
}
extension EmptyViewDelegate{
    func createEmptyView() ->UIView?{
        return nil
    }
}
