//
//  UITableView+Rx.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UITableView {
    func viewForHeaderInSection<Sequence: Swift.Sequence, View: UITableViewHeaderFooterView, Source: ObservableType>
    (identifier: String, viewType: View.Type = View.self)
    -> (_ source: Source)
    -> (_ configure: @escaping (Int, Sequence.Element, View) -> Void)
    -> Disposable
    where Source.Element == Sequence {
        { source in
            { builder in
                let delegate = RxTableViewDelegate<Sequence, View>(identifier: identifier, builder: builder)
                base.rx.delegate.setForwardToDelegate(delegate, retainDelegate: false)
                return source
                    .concat(Observable.never())
                    .subscribe(onNext: { [weak base] elements in
                        delegate.pushElements(elements)
                        base?.reloadData()
                    })
            }
        }
    }
}


final class RxTableViewDelegate<Sequence, View: UITableViewHeaderFooterView>: NSObject, UITableViewDelegate where Sequence: Swift.Sequence {
    let build: (Int, Sequence.Element, View) -> Void
    let identifier: String
    private var elements: [Sequence.Element] = []
    
    init(identifier: String, builder: @escaping (Int, Sequence.Element, View) -> Void) {
        self.identifier = identifier
        self.build = builder
    }
    
    func pushElements(_ elements: Sequence) {
        self.elements = Array(elements)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? View else { return nil }
        guard elements.isEmpty == false else { return nil }
        build(section, elements[section], view)
        return view
    }
}
