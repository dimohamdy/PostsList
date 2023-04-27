//
//  PostsListViewController.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

final class PostsListViewController: UIViewController {

    private var tableDataSource: PostsTableViewDataSource?

    // MARK: Outlets
    private let postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(GeneralTableHeader.self, forHeaderFooterViewReuseIdentifier: GeneralTableHeader.identifier)
        tableView.tag = 1
        tableView.backgroundColor = .systemBackground
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .tertiaryLabel
        tableView.sectionHeaderTopPadding = 0.0
        tableView.accessibilityIdentifier = "PostsListViewController.postsTableView"
        return tableView
    }()

    private lazy var refreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    private let presenter: PostsListPresenterInput

    init(presenter: PostsListPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .green
        view.addSubview(postsTableView)
        NSLayoutConstraint.activate([
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        postsTableView.refreshControl = refreshControl

        tableDataSource = PostsTableViewDataSource(tableView: postsTableView, presenterInput: presenter, tableSections: [])
        postsTableView.dataSource = tableDataSource
        postsTableView.delegate = tableDataSource
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationItem.title = Strings.postListTitle.localized()

        let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        refreshButtonItem.tintColor = .label
        refreshButtonItem.accessibilityIdentifier = "PostsListViewController.refreshButtonItem"

        navigationItem.rightBarButtonItem = refreshButtonItem
    }

    @objc
    private func refresh() {
        presenter.getPosts()
    }
}

// MARK: - PostsListPresenterOutput
extension PostsListViewController: PostsListPresenterOutput {

    private func clearTableView() {
        tableDataSource = nil
        postsTableView.dataSource = nil
        postsTableView.dataSource = nil
        postsTableView.reloadData()
    }

    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
        clearTableView()
        postsTableView.setEmptyView(emptyPlaceHolderType: emptyPlaceHolderType, completionBlock: { [weak self] in
            self?.presenter.getPosts()
        })
    }

    func updateData(error: Error) {
        switch error as? PostsListError {
        case .noResults:
            emptyState(emptyPlaceHolderType: .noResults)
        case .noInternetConnection:
            emptyState(emptyPlaceHolderType: .noInternetConnection)
        default:
            emptyState(emptyPlaceHolderType: .error(message: error.localizedDescription))
        }
    }

    // Update sections not the whole table
    func updateData(tableSections: [TableViewSectionType]) {
        // Clear any placeholder view from tableView
        postsTableView.restore()

        // Reload the tableView
        tableDataSource?.tableSections = tableSections


        // In case the request fired from the refreshControl
        refreshControl.endRefreshing()
    }
}
