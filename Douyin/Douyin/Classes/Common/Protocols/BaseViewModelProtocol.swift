//
//  BaseViewModelProtocol.swift
//  Douyin
//
//  Created by midland on 2019/1/11.
//

import Foundation

protocol BaseViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
