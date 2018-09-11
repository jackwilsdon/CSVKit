//
//  CSVValue.swift
//  CSVKit
//

import Foundation

open class CSVValue: CustomStringConvertible, Equatable {
    private let rawValue: String?

    public var asString: String? { return valid ? rawValue : nil }
    public var asInt: Int? { return valid ? Int(rawValue!) : nil }
    public var asBool: Bool? { return valid ? asInt == 1 : nil }

    public let valid: Bool

    public var description: String {
        if let value = asString {
            return value
        } else {
            return "nil"
        }
    }

    public init(_ csvValue: String) {
        rawValue = csvValue
        valid = true
    }

    public init() {
        rawValue = nil
        valid = false
    }

    public func asEnum<T: RawRepresentable>() -> T? where T.RawValue == Int {
        if let intValue = asInt {
            return T(rawValue: intValue)
        }

        return nil
    }

    public func getRelational(key: String, csv: CSV) -> CSVRow {
        if let value = asString {
            return csv.find(field: key, value: value)
        }

        return CSVRow()
    }
    
    public static func ==(lhs: CSVValue, rhs: CSVValue) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
