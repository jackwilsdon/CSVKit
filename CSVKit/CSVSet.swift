//
//  CSVMapper.swift
//  CSVKit
//
//  Created by Jack Wilsdon on 18/10/2015.
//  Copyright © 2015 Jack Wilsdon. All rights reserved.
//

import Foundation

public class CSVSet {
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
