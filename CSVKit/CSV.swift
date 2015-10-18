//
//  CSV.swift
//  CSVKit
//
//  Created by Jack Wilsdon on 17/10/2015.
//  Copyright © 2015 Jack Wilsdon. All rights reserved.
//

import Foundation

public class CSV: SequenceType {
    public typealias Generator = AnyGenerator<CSVRow>

    private(set) public var headings = [String]()
    private var rows = [[String: String]]()
    public var count: Int { return rows.count }

    public init?(_ lines: [String], separator: Character = ",") {
        for (index, line) in lines.enumerate() {
            let values = line.characters.split(separator).map(String.init)

            if index == 0 {
                headings.appendContentsOf(values)
            } else {
                if values.count != headings.count {
                    return nil
                }

                var row = [String: String]()

                for (heading, value) in zip(headings, values) {
                    row[heading] = value
                }
            }
        }
    }

    public convenience init?(_ raw: String, lineSeparator: Character = "\n", separator: Character = ",") {
        self.init(raw.characters.split(lineSeparator).map(String.init), separator: separator)
    }

    public func find(field: String, value: String) -> CSVRow {
        for (index, row) in rows.enumerate() {
            if row.values.contains(value) {
                return self[index]
            }
        }

        return CSVRow()
    }

    public func generate() -> Generator {
        var index = 0

        return anyGenerator {
            if index >= self.count {
                return nil
            }

            return self[index++]
        }
    }

    public subscript(index: Int) -> CSVRow {
        if index < 0 || index >= rows.count {
            return CSVRow()
        }

        var row = [String: CSVValue]()

        for (heading, value) in rows[index] {
            row[heading] = CSVValue(value)
        }

        return CSVRow(row)
    }
}
