//
//  MYRequestApi.swift
//  
//
//  Created by HJQ on 2018/9/18.
//  Copyright © 2018年 HJQ. All rights reserved.
//

/*
 * Moya Interface configuration
 */

import Foundation
import Moya

enum ApiManager {
    case createVisitor(r: VisitorRequest)
}

extension ApiManager: RxMoyaTargetType & BaseRequest {
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var baseURL: URL {
        return URL.init(string: API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .createVisitor(_):
            return API.CREATE_VISITOR_BY_UDID_URL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createVisitor(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createVisitor(let request):
            print(request.toJSON() ?? [:])
            print(request.parameters ?? [:])
            let params = request.toJSON() ?? [:]
            // print(params)
            // return .requestPlain
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var cacheKey: String? {
        return ""
    }
    
    var isShowHud: Bool {
        return true
    }
    
    var timeOut: Double {
        return 20.0
    }
}

 
