//
//  JSONTransform.swift
//  DouBanBook
//
//  Created by 2017yd on 2019/10/28.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation

class JSONConverter<T:JSONable> {
    
    /// 解析格式为[{},{},{}...]的json数据
    ///  - Parameter jsonArray: json数据
    /// - Returns: JSONable对象集合
    static func getArray(jsonArray: Array<Any>) -> [T]{
        var items = [T]()
        for json in jsonArray{
            let t = T(json: json as! Dictionary<String, Any>)
            items.append(t)
        }
        return items
    }
    
    /// 解析格式为{"key":[{},{}...],"key":"xxx"...}的json数据
    /// - Parameter json: json数据
    /// - Parameter key: 包含[{},{}...]的数据
    /// - Returns: JSONable对象集合
    static func getArray(json:Any, key: String) -> [T] {
        var items = [T]()
        let dic = json as! Dictionary<String,Any>
        let obj = dic["Data"] as! Dictionary<String,Any>
        let array = obj[key] as! Array<Any>
        for i in array{
            let t = T(json: i as! Dictionary<String, Any>)
            items.append(t)
        }
        return items
    }
    
    /// 解析格式为{"key":[{},{}...],"key":"xxx"...}的json数据
    /// - Parameter json: json数据
    /// - Parameter key: 包含[{},{}...]的数据
    /// - Returns: JSONable对象集合
    static func getArrayKey(json:Any, key: String) -> [T] {
        var items = [T]()
        let dic = json as! Dictionary<String,Any>
        let obj = dic["data"] as! Dictionary<String,Any>
         let obj2 = obj["data"] as! Dictionary<String,Any>
         let obj3 = obj2["doclist"] as! Dictionary<String,Any>
        let array = obj[key] as! Array<Any>
        for i in array{
            let t = T(json: i as! Dictionary<String, Any>)
            items.append(t)
        }
        return items
    }
    
    
    
    /// 解析格式为{"key":[{},{}...],"key":"xxx"...}的json数据
    /// - Parameter json: json数据
    /// - Parameter key: 包含[{},{}...]的数据
    /// - Returns: JSONable对象集合
    static func getArraya(json:Any, key: String) -> [T] {
        var items = [T]()
        let dic = json as! Dictionary<String,Any>
        let obj = dic["data"] as! Dictionary<String,Any>
        let array = obj[key] as! Array<Any>
        for i in array{
            let t = T(json: i as! Dictionary<String, Any>)
            items.append(t)
        }
        return items
    }
    
    /// 解析格式为{"key":[{},{}...],"key":"xxx"...}的json数据
    /// - Parameter json: json数据
    /// - Parameter key: 包含[{},{}...]的数据
    /// - Returns: JSONable对象集合
    static func getArrays(json:Any, key: String) -> [T] {
        var items = [T]()
        let dic = json as! Dictionary<String,Any>
        let array = dic[key] as! Array<Any>
        for i in array{
            let t = T(json: i as! Dictionary<String, Any>)
            items.append(t)
        }
        return items
    }
    
    
    /// 解析json字符串{}，整个字符串就是所需要的数据
    /// - Parameter json: json数据
    /// - Returns: JSONable对象集合
    static func getSingle(json:Any) ->T {
        return T(json: json as! Dictionary<String, Any>)
    }

    
    /// 解析格式为{"key":{},"key1":"xxx"...}的json数据
    /// - Parameter json: json数据
    /// - Parameter key: 包含转换的{}数据key
    /// - Returns: JSONable对象集合
    static func getSingle(json:Any, key:String) -> T{
        let t = json as! Dictionary<String,Any>
        let a = t[key] as! Dictionary<String, Any>
        return T(json: a)
    }
    
    
    static func extractUsefulJson(origin:Any, keyArr:Array<Dictionary<String,Bool>>) -> String {
        var obj:String?
        for key in keyArr{
            for k in key{
                let (second , first) = k
                 obj = ripShell(json: origin, isSingle: first, key: second)
            }
        }
        return obj!
    }
    
    static func ripShell(json: Any, isSingle: Bool, key: String) -> String {
        if isSingle {
            var obj = json as! Dictionary<String, Any>
            return obj[key] as! String
        } else {
            var array = json as! Array<Any>
            return array[0] as! String
        }
    }

}
