//
//  DateTimeUtils.swift
//  NetRadioMaster
//
//  Created by retry on 2018/10/3.
//  Copyright © 2018 retry. All rights reserved.
//

import Foundation
extension Date{
    /**
     将当前日期转换为符合pattern格式的字符串
     
     - Parameter pattern: 日期格式如yyyy-MM-dd HH:mm
     
     - Returns: 符合pattern格式的字符串
     **/
    static func dateNowAsString(pattern: String) -> String {
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.string(from: nowDate)
    }
    
    /**
     将指定日期转换为符合pattern格式的字符串
     
     - Parameter date: 指定日期
     - Parameter pattern: 日期格式字符串
     
     - Returns: 符合pattern格式的字符串
     **/
    static func dateAsString(date: Date, pattern: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.string(from: date)
    }

    /**
     将字符串格式的日期转换为Date
     
     - Parameter strDate: 字符串格式的日期如2017-09-18 14:12:35
     - Parameter pattern: 日期格式
     
     - Returns: Date对象
     **/
    static func stringAsDate(strDate: String, pattern: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        let date = formatter.date(from: strDate)
        return date!
    }
    
    /// 判断传入的时间是周几
    /// 返回周一到周日为1 - 7
    static func getWeekDay(dateTime:String)->Int{
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFmt.date(from: dateTime)
        date?.description
        let interval = Int(date!.timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
}
