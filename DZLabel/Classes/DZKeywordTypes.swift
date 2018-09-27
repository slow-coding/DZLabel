//
//  KDKeywordTypes.swift
//  YZJIMLib_Example
//
//  Created by Darren Zheng on 2018/9/27.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public enum DZKeywordType {
    case mention
    case url
    case phone
    case address
    case regex(pattern: String)
    case emoticon(pattern: String?, bounds: CGRect?, imageNameBlock: (String) -> String)
//    case manual(range: NSRange)
}

extension DZKeywordType: Hashable, Equatable {
    public var hashValue: Int {
        switch self {
        case .mention: return -1
        case .url: return -2
        case .phone: return -3
        case .address: return -4
        case .emoticon(let tuple): return tuple.pattern.hashValue
        case .regex(let pattern): return pattern.hashValue
//        case .manual(let range): return range.hashValue
        }
    }
}

public func == (lhs: DZKeywordType, rhs: DZKeywordType) -> Bool {
    switch (lhs, rhs) {
    case (.mention, .mention): return true
    case (.url, .url): return true
    case (.phone, .phone): return true
    case (.address, .address): return true
    case (.emoticon(let t1), .emoticon(let t2)): return t1.pattern == t2.pattern
    case (.regex(let t1), .regex(let t2)): return t1 == t2
//    case (.manual(let t1), .manual(let t2)): return t1 == t2
    default: return false
    }
}
