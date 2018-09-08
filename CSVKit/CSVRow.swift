//
//  CSVRow.swift
//  CSVKit
//

import Foundation

open class CSVRow: Equatable {
    public let headings: [String]?
    public let values: [CSVValue]?
    public let row: [String: CSVValue]?

    public let valid: Bool

    public init(_ csvRow: [String: CSVValue]) {
        headings = Array(csvRow.keys)
        values = Array(csvRow.values)
        row = csvRow
        valid = true
    }

    public init() {
        headings = nil
        values = nil
        row = nil
        valid = false
    }

    public func asRowObject<T: CSVRowObject>(type: T.Type) -> T? {
        return T(self)
    }

    public func contains(heading: String) -> Bool {
        return contains(headings: heading)
    }

    public func contains(headings: String...) -> Bool {
        if !valid {
            return false
        }

        for heading in headings {
            if !self.headings!.contains(heading) {
                return false
            }
        }

        return true
    }

    public subscript(index: String) -> CSVValue {
        if !valid {
            return CSVValue()
        }

        if let value = row![index] {
            return value
        }

        return CSVValue()
    }
    
    public static func ==(lhs: CSVRow, rhs: CSVRow) -> Bool {
        return (lhs.row == nil && rhs.row == nil) || lhs.row! == rhs.row!
    }
}
