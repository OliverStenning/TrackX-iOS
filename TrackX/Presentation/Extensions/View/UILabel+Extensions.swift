//
//  UILabel+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 11/06/2022.
//

import UIKit
import CoreData

public protocol TypographyExtensions: UILabel {
    var lineHeight: CGFloat? { get set }
    var letterSpacing: CGFloat? { get set }
}

extension UILabel: TypographyExtensions {
    
    public var lineHeight: CGFloat? {
        get { paragraphStyle?.maximumLineHeight }
        set {
            let lineHeight = newValue ?? font.lineHeight
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
            addAttribute(.baselineOffset, value: baselineOffset)
            addAttribute(
                .paragraphStyle,
                value: (paragraphStyle ?? NSParagraphStyle())
                    .mutable
                    .withProperty(lineHeight, for: \.minimumLineHeight)
                    .withProperty(lineHeight, for: \.maximumLineHeight)
            )
        }
    }
    
    public var letterSpacing: CGFloat? {
        get { getAttribute(.kern) }
        set { setAttribute(.kern, value: newValue) }
    }
    
}

fileprivate extension UILabel {
    
    var attributes: [NSAttributedString.Key: Any]? {
        get {
            if let attributedText = attributedText, attributedText.length > 0 {
                return attributedText.attributes(at: 0, effectiveRange: nil)
            } else {
                return nil
            }
        }
    }
    
    func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? where AttributeType: Any {
        return attributes?[key] as? AttributeType
    }
    
    func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        attributedText = attributedText?.stringByAddingAttribute(key, value: value)
    }
    
    func removeAttribute(_ key: NSAttributedString.Key) {
        attributedText = attributedText?.stringByRemovingAttribute(key)
    }
    func setAttribute<AttributeType>(
        _ key: NSAttributedString.Key,
        value: AttributeType?
    ) where AttributeType: Any  {
        if let value = value {
            addAttribute(key, value: value)
        } else {
            removeAttribute(key)
        }
    }
    
}

extension UILabel {
    var paragraphStyle: NSParagraphStyle? {
        getAttribute(.paragraphStyle)
    }
}

fileprivate extension NSAttributedString {
    
    var entireRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
    
    func stringByAddingAttribute(_ key: NSAttributedString.Key, value: Any) -> NSAttributedString {
        let changedString = NSMutableAttributedString(attributedString: self)
        changedString.addAttribute(key, value: value, range: self.entireRange)
        return changedString
    }
    
    func stringByRemovingAttribute(_ key: NSAttributedString.Key) -> NSAttributedString {
        let changedString = NSMutableAttributedString(attributedString: self)
        changedString.removeAttribute(key, range: self.entireRange)
        return changedString
    }
}

extension NSParagraphStyle {
    
    var mutable: NSMutableParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)
        return mutable
    }
}

extension NSMutableParagraphStyle {
    
    func withProperty<ValueType>(
        _ value: ValueType,
        for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>
    ) -> NSMutableParagraphStyle {
        self[keyPath: keyPath] = value
        return self
    }
}
