//
//  ReleasesDateCalculator.swift
//  AppStoreClone
//
//  Created by ksmartech on 2023/09/20.
//

import Foundation

class ReleaseDateCalculator {
    
    private let dateFormatter: DateFormatter
    
    init(dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss'Z'", timeZone: TimeZone? = TimeZone(identifier: "Asia/Seoul")) {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = dateFormat
        if let timeZone = timeZone {
            self.dateFormatter.timeZone = timeZone
        }
    }
    
    func timeSinceRelease(_ dateString: String) -> String {
        guard let releaseDate = dateFormatter.date(from: dateString) else {
            return "알 수 없음"
        }
        
        let currentDate = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute], from: releaseDate, to: currentDate)
        
        // 시간 단위 문자열과 Calendar.Component를 배열로 정의
        let timeUnits: [(Calendar.Component, String)] = [
            (.year, "년"), (.month, "개월"), (.weekOfYear, "주"), (.day, "일"), (.hour, "시간"), (.minute, "분")
        ]
        
        // 시간 단위 문자열을 기반으로 시간 간격을 출력
        for (unit, unitString) in timeUnits {
            if let value = components.value(for: unit), value > 0 {
                return "\(value)\(unitString) 전"
            }
        }
        
        return "방금 전"
    }
}
