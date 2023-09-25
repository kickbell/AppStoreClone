//
//  DoubleRoundingTests.swift
//  AppStoreCloneTests
//
//  Created by ksmartech on 2023/09/20.
//

import Foundation
import XCTest
@testable import AppStoreClone

class DoubleRoundingTests: XCTestCase {
    
    func test_소수점_한자리에서_반올림() {
        let number = 3.355559859559559
        let roundedNumber = number.rounded(toDecimalPlaces: 1)
        XCTAssertEqual(roundedNumber, 3.4)
    }
    
    func test_소수점_두자리에서_반올림() {
        let number = 3.355559859559559
        let roundedNumber = number.rounded(toDecimalPlaces: 2)
        XCTAssertEqual(roundedNumber, 3.36)
    }
    
    func test_소수점_세자리에서_반올림() {
        let number = 3.355559859559559
        let roundedNumber = number.rounded(toDecimalPlaces: 3)
        XCTAssertEqual(roundedNumber, 3.356)
    }
    
    func test_소수점_제로에서_반올림() {
        let number = 3.355559859559559
        let roundedNumber = number.rounded(toDecimalPlaces: 0)
        XCTAssertEqual(roundedNumber, 3.0)
    }
    
    func test_음수값에서_소수점_두자리에서_반올림() {
        let number = -3.355559859559559
        let roundedNumber = number.rounded(toDecimalPlaces: 2)
        XCTAssertEqual(roundedNumber, -3.36)
    }
    
    func test_영에서_반올림() {
        let number = 0.0
        let roundedNumber = number.rounded(toDecimalPlaces: 1)
        XCTAssertEqual(roundedNumber, 0.0)
    }
    
    func test_큰_값에서_소수점_세자리에서_반올림() {
        let number = 123456.789
        let roundedNumber = number.rounded(toDecimalPlaces: 3)
        XCTAssertEqual(roundedNumber, 123456.789)
    }
    
    func test_큰_값에서_소수점_한자리에서_반올림() {
        let number = 123456.789
        let roundedNumber = number.rounded(toDecimalPlaces: 1)
        XCTAssertEqual(roundedNumber, 123456.8)
    }
    
    func test_큰_음수값에서_소수점_두자리에서_반올림() {
        let number = -98765.4321
        let roundedNumber = number.rounded(toDecimalPlaces: 2)
        XCTAssertEqual(roundedNumber, -98765.43)
    }
    
    func test_아주_작은_값에서_소수점_네자리에서_반올림() {
        let number = 0.000123456789
        let roundedNumber = number.rounded(toDecimalPlaces: 4)
        XCTAssertEqual(roundedNumber, 0.0001)
    }
    
}
