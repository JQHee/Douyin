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
