//
//  ObservableType+Rx.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import Foundation
import RxSwift

extension ObservableType {
    public func unwrap<Result>() -> Observable<Result> where Element == Result? {
        return self.compactMap { $0 }
    }
}
