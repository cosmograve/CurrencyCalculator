//
//  String.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 03.08.2022.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)

        return ceil(boundingBox.height)
    }

    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension String {
    var color: UIColor {
        return UIColor(self)
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var fileName: String {
        return lastPathComponent.deletingPathExtension
    }
    
    var base64Encode: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data.base64EncodedString(options: .init(rawValue: 0))
    }
    
    var base64Decode: String? {
        guard let data = Data(base64Encoded: self, options: .init(rawValue: 0)) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    func index(at: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: at)
    }
    
    subscript(index: Int) -> Character {
        return self[self.index(at: index)]
    }
    
    subscript(range: Range<Int>) -> Substring {
        return self[self.index(at: range.lowerBound)..<self.index(at: range.upperBound)]
    }
    
    subscript(range: CountableClosedRange<Int>) -> Substring {
        return self[self.index(at: range.lowerBound)...self.index(at: range.upperBound)]
    }
    
    subscript(range: PartialRangeUpTo<Int>) -> Substring {
        return self[..<self.index(at: range.upperBound)]
    }
    
    subscript(range: PartialRangeFrom<Int>) -> Substring {
        return self[self.index(at: range.lowerBound)...]
    }
    
    subscript(range: PartialRangeThrough<Int>) -> Substring {
        return self[...self.index(at: range.upperBound)]
    }
    
    static func localizedKey(_ key: String, from fileName: String? = nil) -> String {
        return NSLocalizedString(key, tableName: fileName, bundle: Bundle.main, value: key, comment: "")
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
