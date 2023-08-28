//
//  Results.swift
//  MediaAPI
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Swift.Error)
}
