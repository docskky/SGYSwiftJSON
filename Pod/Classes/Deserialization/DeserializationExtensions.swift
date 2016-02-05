//
//  SGYDeserializationExtensions.swift
//  SGYSwiftJSON
//
//  Created by Sean Young on 8/23/15.
//  Copyright © 2015 Sean Young. All rights reserved.
//

import Foundation

// MARK: JSONCollectionCreatable Conformance -

extension RangeReplaceableCollectionType where Self: JSONCollectionCreatable {
    public init(array: [AnyObject]) {
        self.init()
        array.forEach { if let e = $0 as? Generator.Element { append(e) } }
        
    }
}

extension Array: JSONCollectionCreatable { }

extension Set: JSONCollectionCreatable {
    public init(array: [AnyObject]) {
        self.init()
        array.forEach { if let e = $0 as? Generator.Element { insert(e) } }
        
    }
}


// MARK: JSONDictionaryCreatable Conformance -

extension Dictionary: JSONDictionaryCreatable {
    public init(dictionary: [String: AnyObject]) {
        self.init()
        dictionary.forEach {
            if let k = $0 as? Key, v = $1 as? Value { self[k] = v }
        }
    }
}

// MARK: JSONLeafCreatable Conformance -
// MARK: String

extension String: JSONLeafCreatable {
    public init?(jsonValue: JSONLeafValue) {
        switch jsonValue {
        case .String(let string as String): self = string
        case .Number(let number): self = "\(number)"
        default: return nil
        }
    }
}

// MARK: Numeric Structs

extension Int: JSONLeafCreatable {
    public init?(jsonValue: JSONLeafValue) {
        switch jsonValue {
        case .String(let string as String):
            guard let int = Int(string) else { return nil }
            self = int
        case .Number(let number):
            self = number.integerValue
        default:
            return nil
        }
    }
}

extension UInt: JSONLeafCreatable {
    public init?(jsonValue: JSONLeafValue) {
        switch jsonValue {
        case .String(let string as String):
            guard let uint = UInt(string) else { return nil }
            self = uint
        case .Number(let number):
            self = number.unsignedIntegerValue
        default:
            return nil
        }
    }
}

extension Float: JSONLeafCreatable {
    public init?(jsonValue: JSONLeafValue) {
        switch jsonValue {
        case .String(let string as String):
            guard let float = Float(string) else { return nil }
            self = float
        case .Number(let number):
            self = number.floatValue
        default:
            return nil
        }
    }
}

extension Double: JSONLeafCreatable {
    public init?(jsonValue: JSONLeafValue) {
        switch jsonValue {
        case .String(let string as String):
            guard let double = Double(string) else { return nil }
            self = double
        case .Number(let number):
            self = number.doubleValue
        default:
            return nil
        }
    }
}

extension Bool: JSONLeafCreatable {
    public init?(jsonValue: JSONLeafValue) {
        // Use Int's conversion
        guard let int = Int(jsonValue: jsonValue) else { return nil }
        self = Bool(int)
    }
}


