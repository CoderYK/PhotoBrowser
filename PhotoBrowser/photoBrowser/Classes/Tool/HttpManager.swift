//
//  HttpManager.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import Foundation
import AFNetworking

class HttpManager: AFHTTPSessionManager {

    //将类设计成为单例对象
    static let shareInstance: HttpManager = {
        let tool = HttpManager()
        // "text/html" 未识别内容类型解决
       tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        
       return tool
    }()
    
    
    func loadHomeData(finshedCallBack: (resultArray : [[String : NSObject]]?, error : NSError?) -> ()) {
        // 1.获取请求的 URLString
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=0&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2"
        
        // 2.发送网络请求
        GET(urlString, parameters: nil, success: { (_, result) -> Void in
            
            // 1.将 result 转为字典类型
            guard let resultDict = result as? [String : NSObject] else {
                print("没有拿到正确数组")
                return
            }
            
            // 2.将字典数组从字典中取出
            let dictArray = resultDict["data"] as? [[String : NSObject]]
            
            // 3. 将数据回调出去
            finshedCallBack(resultArray: dictArray, error: nil)
            
            }) { (_, error) -> Void in
              finshedCallBack(resultArray: nil, error: error)
        }
    }
}
