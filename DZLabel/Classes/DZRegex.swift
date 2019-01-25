//
//  DZRegex.swift
//
//  Created by Darren Zheng on 16/5/19.
//

import UIKit

struct DZRegexMatchModel {
    var pattern: DZKeywordType
    var results: [NSTextCheckingResult]
}

final class DZRegex {
    
    static let DZRegexPatternEmotion = "\\[[^\\[\\]]+\\]"
    static let DZRegexPatternMention = "[@]+(\\w|[-|.])*"
    
    static let URLPrefix = "url:"
    static let PhonePrefix = "tel:"
    static let KeywordPrefix = "kwd:"
    static let MentionPrefix = "mention:"
    static let MapPrefix = "map:"
    static let CustomPrefix = "cst:"
    static let ManualPrefix = "manual:"
}

// MARK: 通用方法
extension DZRegex {
    
    class func matchPattern(_ pattern: String?, text: String?) -> [NSTextCheckingResult] {
        guard let pattern = pattern, let text = text
            else { return [NSTextCheckingResult]() }
        return (try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0)).matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))) ?? []
    }
    
    class func firstMatchPattern(_ pattern: String?, text: String?) -> NSTextCheckingResult? {
        guard let pattern = pattern, let text = text
            else { return nil }
        return try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0)).firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
    }
    
}

extension DZRegex {
    
    // 检测 电话号
    class func phoneNumberResultsInText(_ text: String?, detector: NSDataDetector? = nil) -> [NSTextCheckingResult] {
        guard let text = text
            else { return [NSTextCheckingResult]() }
        let input = text
        let detector = detector ?? (try? NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue))
        let matches = detector?.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        return matches ?? [NSTextCheckingResult]()
    }
    
    // 检测 地址
    class func mapResultsInText(_ text: String?, detector: NSDataDetector? = nil) -> [NSTextCheckingResult] {
        guard let text = text
            else { return [NSTextCheckingResult]() }
        let input = text
        let detector = detector ?? (try? NSDataDetector(types: NSTextCheckingResult.CheckingType.address.rawValue))
        return detector?.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) ?? [NSTextCheckingResult]()
    }
    
    // 检测 表情
    class func emotionResultsInText(_ text: String?, pattern: String) -> [NSTextCheckingResult] {
        return matchPattern(pattern, text: text)
    }
    
    // 通用检测
    class func resultsInText(_ text: String?, pattern: String) -> [NSTextCheckingResult] {
        return matchPattern(pattern, text: text)
    }
    
    // 检测 URL
    class func urlResultsInText(_ text: String?) -> [NSTextCheckingResult] {
        guard let text = text
            else { return [NSTextCheckingResult]() }
        let input = text
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        var matches = [NSTextCheckingResult]()
        for match in detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) {
            matches.append(match)
        }
        return matches
    }
    
    // 检测 @提及
    class func mentionResultsInText(_ text: String?) -> [NSTextCheckingResult] {
        return matchPattern(DZRegexPatternMention, text: text)
    }
    
    
}
