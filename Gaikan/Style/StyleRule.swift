//
// This file is part of Gaikan
//
// Created by JC on 30/08/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation

public struct StyleRule : DictionaryLiteralConvertible {
    public typealias Key = Property
    public typealias Value = Any?

    private var attributes : Dictionary<Key, Value>

    public init(attributes: [Key:Value]) {
        self.attributes = attributes
    }

    public init(dictionaryLiteral elements: (Key, Value)...) {
        var attributes = Dictionary<Key, Value>()

        for (attributeName, attributeValue) in elements {
            attributes[attributeName] = attributeValue
        }

        self.attributes = attributes
    }

    public init(_ styleBlock: (inout style: StyleRule) -> ()) {
        self.init(attributes: [:])

        styleBlock(style: &self)
    }

    public func extends(styles: StyleRule?...) -> StyleRule {
        var composedAttributes: [Key:Value] = [:]

        for style in styles {
            if let styleAttributes = style?.attributes  {
                composedAttributes.gaikan_merge(styleAttributes)
            }
        }

        return StyleRule(attributes: composedAttributes.gaikan_merge(self.attributes))
    }

    private subscript(keyname: Property) -> Value {
        get { return self.attributes[keyname] != nil ? self.attributes[keyname]! : nil }
    }
}

public extension StyleRule {
    public var background: BackgroundValue? {
        get { return self[.Background].map { return $0 as! BackgroundValue } }
        set { self.attributes[.Background] = newValue }
    }

    public var border: Border? {
        get { return self[.Border].map { return $0 as! Border } }
        set { self.attributes[.Border] = newValue }
    }
    
    public var corners: Corners? {
        get { return self[.Corners].map { return $0 as! Corners } }
        set { self.attributes[.Corners] = newValue }
    }

    public var color: UIColor? {
        get { return self[.Color].map { return $0 as! UIColor } }
        set { self.attributes[.Color] = newValue }
    }

    public var font: UIFont? {
        get { return self[.Font].map { return $0 as! UIFont } }
        set { self.attributes[.Font] = newValue }
    }

    public var textAlign: NSTextAlignment? {
        get { return self[.TextAlign].map { return $0 as! NSTextAlignment } }
        set { self.attributes[.TextAlign] = newValue }
    }

    public var tintColor: UIColor? {
        get { return self[.TintColor].map { return $0 as! UIColor } }
        set { self.attributes[.TintColor] = newValue }
    }

    public var visible: Bool? {
        get { return self[.Visible].map { return $0 as! Bool } }
        set { self.attributes[.Visible] = newValue }
    }
}