//
//  RequestManage.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/6/18.
//

import Foundation
import UIKit
import Alamofire

private let NetworkAPIBaseURL = ""

class RequestManage {
    //单例
    static let shared = RequestManage()
    private init() {}
    
    @discardableResult
    func requestGetData (path: String, parameters: Parameters?, completion: @escaping (Result<Data, Error>) -> Void) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   requestModifier: { $0.timeoutInterval = 15 })//超时时间
            .responseData { (response) in
                switch response.result {
                case let .success(data) : completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
            }
    }
    
    @discardableResult //忽略返回值
    func requestPostData(path: String, parameters: Parameters?, completion: @escaping (Result<Data, Error>)->Void) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { (response) in
                switch response.result {
                case let .success(data) : completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
            }
    }
}
