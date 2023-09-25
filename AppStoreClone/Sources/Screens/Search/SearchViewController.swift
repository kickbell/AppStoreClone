//
//  ViewController.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, View {
    //MARK: - Properties
    
    weak var coordinator: SearchCoordinator?
    
    var disposeBag = DisposeBag()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Views
    
    private let searchController: UISearchController = {
        let searchControler = UISearchController(searchResultsController: nil)
        searchControler.searchBar.placeholder = "게임, 앱, 스토리 등"
        return searchControler
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset.right = 20
        tableView.register(headerFooterType: RecentSearchHeaderView.self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(SearchedTableViewCell.self, forCellReuseIdentifier: SearchedTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .large
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
}

//MARK: - Reactors

extension SearchViewController {
    func bind(reactor: SearchReactor) {
        
        //MARK: - Action
        
        searchController.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.updateRecentQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.merge(
            searchController.searchBar.rx.searchButtonClicked
                .map { self.searchController.searchBar.text ?? "" },
            tableView.rx.modelSelected(SearchReactor.DisplayItem.self)
                .filter { $0.type.isRecent }
                .map { $0.type.recentValue }
                .unwrap()
        )
        .do(onNext: { query in
            reactor.action.onNext(.saveRecentQuery(query))
        })
        .map { Reactor.Action.updateAppQuery($0) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        
        //MARK: - State
        
        reactor.state.map(\.query)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(to: searchController.searchBar.rx.text)
            .disposed(by: disposeBag)
                
        reactor.state.map(\.displayItems)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.viewForHeaderInSection(
                identifier: RecentSearchHeaderView.reuseIdentifier,
                viewType: RecentSearchHeaderView.self
            )) { _, item, headerView in
                headerView.isHidden = !item.type.isRecent
            }
            .disposed(by: disposeBag)
        
        reactor.state.map(\.displayItems)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] items in
                if !items.isEmpty, let searchText = self?.searchController.searchBar.text {
                    UIAccessibility.post(
                        notification: .announcement,
                        argument: "\(searchText)에 대한 \(items.count)개의 데이터가 로딩되었습니다."
                    )
                }
            })
            .bind(to: tableView.rx.items) { (tableView, row, item) in
                switch item.type {
                case let .app(data):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedTableViewCell.reuseIdentifier) as? SearchedTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(with: data)
                    cell.tapClosure = { self.coordinator?.didSelected(with: data) }
                    return cell
                    
                case let .recent(text):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier) else {
                        return UITableViewCell()
                    }
                    let searchText = self.searchController.searchBar.text ?? ""
                    
                    if searchText.isEmpty {
                        cell.textLabel?.textColor = .systemBlue
                        cell.imageView?.tintColor = .systemBlue
                        cell.imageView?.image = nil
                    } else {
                        cell.textLabel?.textColor = .label
                        cell.imageView?.tintColor = .label
                        cell.imageView?.image = UIImage(systemName: "magnifyingglass")
                    }
                    
                    cell.textLabel?.text = text
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        //MARK: - UI
        
        tableView.rx.modelSelected(SearchReactor.DisplayItem.self)
            .filter { $0.type.isApp }
            .map { $0.type.appValue }
            .unwrap()
            .subscribe(onNext: { data in
                self.coordinator?.didSelected(with: data)
            })
            .disposed(by: disposeBag)

        reactor.state.map(\.isLoading)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isAnimating, tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.error)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let error = error else { return }
                self?.presentAlert(title: "ERROR", message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Methods

extension SearchViewController {
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Setups

extension SearchViewController {
    private func setup() {
        setupUI()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.backgroundColor = .systemBackground
        title = "검색"
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}



