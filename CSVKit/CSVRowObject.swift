//
//  CSVRowObject.swift
//  CSVKit
//

import Foundation

public class CSVRowObject: CSVRow {
    public required init(_ row: CSVRow) {
        if row.valid {
            super.init(row.row!)
        } else {
            super.init()
        }
    }
}
