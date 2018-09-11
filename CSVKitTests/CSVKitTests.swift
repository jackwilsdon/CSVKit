//
//  CSVKitTests.swift
//  CSVKitTests
//
//  Created by Jack Wilsdon on 18/10/2015.
//  Copyright © 2015 Jack Wilsdon. All rights reserved.
//

import XCTest
import CSVKit

func parse(bundle: Bundle, forResource fileName: String, withExtension: String) -> CSV? {
    guard let url = bundle.url(forResource: fileName, withExtension: withExtension) else {
        XCTFail("Unable to find color data file '\(fileName)'")
        return nil
    }
    let data: Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        XCTFail("Reading contents of URL \(url) threw error: \(error)")
        return nil
    }
    guard let string = String(data: data, encoding: .utf8) else {
        XCTFail("Unable to convert data '\(data)' into String from '\(fileName)'")
        return nil
    }
    
    let lines = string.split(separator: "\r\n").map { String($0) }
    let result = CSV(lines)
    if result == nil {
        XCTFail("Unable to create CSV object")
        return nil
    }
    
    return result
}

class CSVKitTests: XCTestCase {
    func testParse() {
        guard let csv = parse(bundle: Bundle(for: type(of: self)), forResource: "TestData", withExtension: "csv") else {
            XCTFail("Unable to create CSV object")
            return
        }
        
        XCTAssertEqual(csv.headings.count, 30, "Expect 30 columns")
        XCTAssertEqual(csv.rows.count, 1866, "Expect 1866 rows")
    }
}
