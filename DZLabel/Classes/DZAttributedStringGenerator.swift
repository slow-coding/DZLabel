//
//  DZAttributedStringGenerator.swift
//
//  Created by Darren Zheng on 2017/8/21.
//

/**
 
 DZAttributedStringGenerator is for easily generating NSMutableAttributedString classes
 
 Features:
 - Straightforward
 - Chainable calling
 - Directly manipulating images
 
 -------- Coverage (last update: 20170907) --------
 
 ### Manipulate
 
 append                              =     appendAttributedString
 replace                             =     replaceCharacters
 insert                              =     insert
 delete                              =     deleteCharacters
 
 ### Attributes dictionary
 
 NSFontAttributeName                 =     font
 NSForegroundColorAttributeName      =     textColor
 NSBackgroundColorAttributeName
 NSLigatureAttributeName
 NSKernAttributeName
 NSStrikethroughStyleAttributeName
 NSStrikethroughColorAttributeName
 NSUnderlineStyleAttributeName       =     underline
 NSUnderlineColorAttributeName
 NSStrokeWidthAttributeName
 NSStrokeColorAttributeName
 NSShadowAttributeName
 NSTextEffectAttributeName
 NSAttachmentAttributeName           =     insertImage, replaceImage
 NSLinkAttributeName                 =     link
 NSBaselineOffsetAttributeName
 NSObliquenessAttributeName
 NSExpansionAttributeName
 NSVerticalGlyphFormAttributeName
 
 ### Paragraph style                 =     DZMakeParagraphStyle
 
 alignment                           =     alignment
 firstLineHeadIndent
 headIndent
 tailIndent
 lineBreakMode                       =     lineBreakMode
 maximumLineHeight
 lineSpacing
 paragraphSpacing
 paragraphSpacingBefore
 baseWritingDirection
 lineHeightMultiple
 
 
 -------- Example --------
 
 DZMakeRichText(text: "hello world")
 .font(<#your font#>)
 .textColor(<#your color#>, range: NSRange(location: 0, length: 6))
 .textColor(<#your color#>, range: NSRange(location: 6, length: 5))
 .underline(color: <#your color#>)
 .generateAttributedString // or generateAttributes
 
 */

import UIKit

public class DZAttributedStringGenerator {
    public var item: NSMutableAttributedString?
    
    fileprivate var attributedString: NSMutableAttributedString?
    fileprivate var attributes = [NSAttributedStringKey: Any]()
    fileprivate var style: NSMutableParagraphStyle?
    fileprivate var styleRange: NSRange?
    
    /// begin <- plain text
    public init(text: String?) {
        attributedString = NSMutableAttributedString(string: text ?? "")
    }
    
}

// MARK: - Manipulate -
public extension DZAttributedStringGenerator {
    
    /// end 1 -> NSMutableAttributedString
    public var generateAttributedString: NSMutableAttributedString? {
        if let style = style, let string = attributedString?.string {
            attributedString?.addAttributes([NSAttributedStringKey.paragraphStyle: style], range:  styleRange ?? fullRange(string) )
        }
        return attributedString
    }
    
    /// end 2 -> Attributes
    public var generateAttributes: [NSAttributedStringKey: Any]? {
        if let style = style {
            attributes[NSAttributedStringKey.paragraphStyle] = style
        }
        return attributes
    }
    
    // append
    @discardableResult
    public func appendAttributedString(_ attri: NSAttributedString?) -> Self {
        if let attri = attri {
            attributedString?.append(attri)
        }
        return self
    }
    
    // append
    @discardableResult
    public func appendString(_ string: String?) -> Self {
        if let string = string {
            attributedString?.append(NSAttributedString(string: string))
        }
        return self
    }
    
    // replace
    @discardableResult
    public func replaceCharacters(in range: NSRange, with attrString: NSAttributedString?) -> Self {
        if let attrString = attrString {
            attributedString?.replaceCharacters(in: range, with: attrString)
        }
        return self
    }
    
    // insert
    @discardableResult
    public func insert(_ attrString: NSAttributedString?, at loc: Int) -> Self {
        if let attrString = attrString {
            attributedString?.insert(attrString, at: loc)
        }
        return self
    }
    
    // delete
    @discardableResult
    public func deleteCharacters(in range: NSRange) -> Self {
        attributedString?.deleteCharacters(in: range)
        return self
    }
    
}


// MARK: - Attributes dictionary -
public extension DZAttributedStringGenerator {
    
    fileprivate func fullRange(_ string: String) -> NSRange {
        return NSRange(location: 0, length: string.count)
    }
    
    @discardableResult
    public func font(_ font: UIFont?, range: NSRange? = nil) -> Self {
        guard let font = font, let string = attributedString?.string else {
            return self
        }
        attributes[NSAttributedStringKey.font] = font
        attributedString?.addAttributes([NSAttributedStringKey.font: font], range: range ?? fullRange(string))
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor?, range: NSRange? = nil) -> Self {
        guard let color = color, let string = attributedString?.string else {
            return self
        }
        attributes[NSAttributedStringKey.foregroundColor] = color
        attributedString?.addAttributes([NSAttributedStringKey.foregroundColor: color], range: range ?? fullRange(string))
        return self
    }
    
    @discardableResult
    public func underline(color: UIColor?, range: NSRange? = nil) -> Self {
        guard let string = attributedString?.string else {
            return self
        }
        var attri: [NSAttributedStringKey: Any] = [NSAttributedStringKey.underlineStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue)]
        
        if let color = color {
            attri[NSAttributedStringKey.underlineColor] = color
        }
        attri.forEach {
            attributes[$0.0] = $0.1
        }
        attributedString?.addAttributes(attri, range: range ?? fullRange(string))
        return self
    }
    
    @discardableResult
    public func link(url: URL?, range: NSRange? = nil) -> Self {
        guard let url = url, let string = attributedString?.string else {
            return self
        }
        attributes[NSAttributedStringKey.link] = url
        attributedString?.addAttributes([NSAttributedStringKey.link: url], range: range ?? fullRange(string))
        return self
    }
    
    @discardableResult
    public func insertImage(imageName: String, at index: Int, bounds: CGRect? = nil) -> Self {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: imageName)
        if let font = attributes[NSAttributedStringKey.font] as? UIFont {
            textAttachment.bounds = CGRect(x: 0, y: font.descender, width: font.lineHeight, height: font.lineHeight)
        }
        if let bounds = bounds {
            textAttachment.bounds = bounds
        }
        attributes[NSAttributedStringKey.attachment] = textAttachment
        attributedString?.insert(NSAttributedString(attachment: textAttachment), at: index)
        return self
    }
    
    @discardableResult
    public func replaceImage(imageName: String, with range: NSRange, bounds: CGRect? = nil) -> Self {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: imageName)
        if let font = attributes[NSAttributedStringKey.font] as? UIFont {
            textAttachment.bounds = CGRect(x: 0, y: font.descender, width: font.lineHeight, height: font.lineHeight)
        }
        if let bounds = bounds {
            textAttachment.bounds = bounds
        }
        attributes[NSAttributedStringKey.attachment] = textAttachment
        attributedString?.replaceCharacters(in: range, with: NSAttributedString(attachment: textAttachment))
        return self
    }
    
    
    
}

public extension DZAttributedStringGenerator {
    @discardableResult
    public func paragraphStyle(_ style :NSMutableParagraphStyle?, range: NSRange? = nil) -> Self {
        self.style = style
        self.styleRange = range
        return self
    }
}


public class DZMakeParagraphStyle {
    
    fileprivate var paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    
    public init() {
        
    }
    
    /// end -> DZMakeParagraphStyle
    public func end() -> NSMutableParagraphStyle? {
        return paragraphStyle
    }
    
}

// MARK: - Paragraph style -
public extension DZMakeParagraphStyle {
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        paragraphStyle.alignment = alignment
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode, range: NSRange? = nil) -> Self {
        paragraphStyle.lineBreakMode = lineBreakMode
        return self
    }
    
}

