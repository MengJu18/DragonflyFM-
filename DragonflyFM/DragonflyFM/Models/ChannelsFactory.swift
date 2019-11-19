//
//  ChannelsFactory.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
import CoreData
let navigations = "ChannelsFactory.navigation"

class ChannelsFactory {
//    // 懒汉式单例模式
    var repository:Repositry<VMChannels>
    private static var instance: ChannelsFactory?
    var app:AppDelegate?
    private init(_ app:AppDelegate) {
        repository = Repositry<VMChannels>(app)
        self.app = app
    }
    
    static func getInstance(_ app:AppDelegate) -> ChannelsFactory {
        if let obj = instance{
            return obj
        } else {
            let token = "net.lzzy.factory.channels"
            DispatchQueue.once(token: token, block: {
                if instance == nil{
                    instance = ChannelsFactory(app)
                }
            })
            return instance!
        }
    }
    
    func getAllChannels() throws -> [VMChannels] {
        return try repository.get()
    }
    
    func isChannelsRxists(channels:VMChannels) -> Bool {
        var matchId = false
        if let contentId = channels.contentId {
            matchId = try! repository.isEntityExists([VMChannels.colContentId], keyword: "\(contentId)")
        }
        return matchId
    }
    
    func addChannels(channels: VMChannels) -> (Bool ,String?) {
        do {
            if try repository.isEntityExists([VMChannels.colTitle], keyword: channels.title!){
                return (false , "同样的类别已经存在")
            }
            try repository.insert(vm: channels)
            NotificationCenter.default.post(name: NSNotification.Name(navigations), object: nil)
            return (true, nil)
        }catch DataError.entityExistsError(let info){
            return (false,info)
        }catch {
            return (false,error.localizedDescription)
        }
    }
    
     func removeChannels(channels: VMChannels) throws ->(Bool,String?) {
        do {
            if let contentId = channels.contentId{
                let channel = try repository.getby([VMChannels.colContentId], keyword: "\(contentId)")
                if channel.count > 0 {
                    try repository.delete(id: channel[0].id )
                    NotificationCenter.default.post(name: NSNotification.Name(navigations), object: nil)
                    return (true,nil)
                }
            }
             return (false,"没有找到本地数据，是否已删除？")
        }catch DataError.deleteExistsError(let info){
            return (false,info)
        }catch{
            return (false,error.localizedDescription)
        }
        
    }
    
}
extension DispatchQueue {
    private static var _onceTracker = [String]()
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
}
}
