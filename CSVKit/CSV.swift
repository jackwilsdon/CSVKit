//
//  CSV.swift
//  CSVKit
//

import Foundation

open class CSV {
    public typealias Element = CSVRow

    private(set) public var headings = [String]()
    private(set) public var rows = [CSVRow]()
    public var count: Int { return rows.count }

    public init?(_ lines: [String], separator: Character = ",") {
        for (index, line) in lines.enumerated() {
            let values = line.split(separator: separator, maxSplits: Int.max, omittingEmptySubsequences: false).map(String.init)

            if index == 0 {
                headings.append(contentsOf: values)
            } else {
                if values.count != headings.count {
                    return nil
                }

                var row = [String: CSVValue]()

                for (heading, value) in zip(headings, values) {
                    row[heading] = CSVValue(value)
                }

                rows.append(CSVRow(row))
            }
        }
    }

    public convenience init?(_ raw: String, lineSeparator: Character = "\n", separator: Character = ",") {
        self.init(raw.split(separator: lineSeparator).map(String.init), separator: separator)
    }

    public func find(field: String, value: String) -> CSVRow {
        for (index, row) in rows.enumerated() {
            if let values = row.values {
                if values.contains(where: { (compare) -> Bool in
                    return compare.asString == value
                }) {
                    return self[index]
                }
            }
        }

        return CSVRow()
    }

    public func rowsAsRowObjects<T: CSVRowObject>(type: T.Type) -> [T]? {
        let rowObjects = rows.map({ T($0) })

        if rowObjects.contains(where: { (value) -> Bool in
            return value == nil
        }) {
            return nil
        }

        return rowObjects.map({ $0! })
    }

    public subscript(index: Int) -> CSVRow {
        if index < 0 || index >= rows.count {
            return CSVRow()
        }

        return rows[index]
    }
}
