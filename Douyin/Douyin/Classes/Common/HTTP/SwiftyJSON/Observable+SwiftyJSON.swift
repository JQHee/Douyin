//
//  Observable+SwiftyJSON.swift
//  Douyin
//
//  Created by midland on 2019/1/11.
//

import Foundation

extension ObservableType where E == Any {
    public func sJMapJSON(_ json : @escaping ((E) -> JSON)) -> Observable<Any> {
        return flatMap { (result) -> Observable<Any> in
            return Observable.just(json(result).object)
        }
    }
}
