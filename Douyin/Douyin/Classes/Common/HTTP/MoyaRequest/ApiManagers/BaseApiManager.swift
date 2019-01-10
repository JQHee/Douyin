//
//  BaseApiManager.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import Foundation
import Moya


// add new protocol
protocol MoyaAddable {
    var cacheKey: String? { get }
    var isShowHud: Bool { get }
    var timeOut: Double { get }
}

// get request parameters
protocol BaseRequest {
    var parameters: [String: Any]? { get }
}

extension BaseRequest {
    var parameters: [String: Any]? {
        var param = [String: Any]()
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            param[label] = value
        }
        
        return param
    }
}
