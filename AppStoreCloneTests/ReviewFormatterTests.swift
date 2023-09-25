//
//  ReviewFormatterTests.swift
//  AppStoreCloneTests
//
//  Created by ksmartech on 2023/09/20.
//

import Foundation
import XCTest
@testable import AppStoreClone

class ReviewFormatterTests: XCTestCase {
    
    func test리뷰_개수_포맷_천단위_미만() {
        // Given
        let reviewCount: Int64 = 500
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "500")
    }
    
    func test리뷰_개수_포맷_천단위() {
        // Given
        let reviewCount: Int64 = 3_500
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "3.5천")
    }
    
    func test리뷰_개수_포맷_천단위_정확히_천() {
        // Given
        let reviewCount: Int64 = 4_000
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "4천")
    }
    
    func test리뷰_개수_포맷_만단위() {
        // Given
        let reviewCount: Int64 = 25_000
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "2.5만")
    }
    
    func test리뷰_개수_포맷_만단위_정확히_만() {
        // Given
        let reviewCount: Int64 = 30_000
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "3만")
    }
    
    func test리뷰_개수_포맷_만단위_이상() {
        // Given
        let reviewCount: Int64 = 12_345
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "1.2만")
    }
    
    func test리뷰_개수_포맷_반올림() {
        // Given
        let reviewCount: Int64 = 13_567
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "1.4만")
    }
    
    func test리뷰_개수_포맷_천단위_정확히_천_반올림() {
        // Given
        let reviewCount: Int64 = 5_500
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "5.5천")
    }
    
    func test리뷰_개수_포맷_만단위_정확히_만_반올림() {
        // Given
        let reviewCount: Int64 = 40_000
        
        // When
        let formattedCount = ReviewFormatter.format(with: reviewCount)
        
        // Then
        XCTAssertEqual(formattedCount, "4만")
    }
}
