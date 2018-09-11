//
//  CSVMapper.swift
//  CSVKit
//

import Foundation

open class CSVSet {
    private var csvs: [String: CSV] = [String: CSV]()

    public init(csvsArray: [[String: CSV]]) {
        for csvs in csvsArray {
            for (name, csv) in csvs {
                self.csvs[name] = csv
            }
        }
    }

    public init(csvs: [String: CSV]) {
        self.csvs = csvs
    }

    public subscript(name: String) -> CSV? {
        get {
            return csvs[name]
        }

        set(value) {
            csvs[name] = value
        }
    }
}
