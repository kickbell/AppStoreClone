//
//  ReleaseDateCalculatorTests.swift
//  AppStoreCloneTests
//
//  Created by ksmartech on 2023/09/20.
//

import XCTest
import Foundation
@testable import AppStoreClone

class ReleaseDateCalculatorTests: XCTestCase {

    var calculator: ReleaseDateCalculator!

    override func setUp() {
        super.setUp()
        calculator = ReleaseDateCalculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    func test_방금_전_테스트() {
        let dateString = "2023-09-18T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "2일 전")
    }

    func test_1일_전_테스트() {
        let dateString = "2023-09-17T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "3일 전")
    }

    func test_1주_전_테스트() {
        let dateString = "2023-09-11T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "1주 전")
    }

    func test_1개월_전_테스트() {
        let dateString = "2023-08-18T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "1개월 전")
    }

    func test_1년_전_테스트() {
        let dateString = "2022-09-18T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "1년 전")
    }

    func test_다른_타임존_테스트() {
        let timeZone = TimeZone(identifier: "America/New_York")!
        let calculator = ReleaseDateCalculator(timeZone: timeZone)
        let dateString = "2023-09-18T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "1일 전")
    }

    func test_미래_날짜_테스트() {
        let dateString = "2023-09-20T12:00:00Z"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "11시간 전")
    }

    func test_무효한_날짜_테스트() {
        let dateString = "Invalid Date"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "알 수 없음")
    }

    func test_커스텀_포맷_테스트() {
        let calculator = ReleaseDateCalculator(dateFormat: "dd-MM-yyyy HH:mm:ss")
        let dateString = "18-09-2023 12:00:00"
        let result = calculator.timeSinceRelease(dateString)
        XCTAssertEqual(result, "2일 전")
    }
}
