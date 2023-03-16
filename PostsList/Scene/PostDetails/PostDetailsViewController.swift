//
//  PostDetailsViewController.swift
//  PostDetails
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit
extension PostDetailsViewController {
    enum Tags: Int {
        case refresh = 1
    }
}

final class PostDetailsViewController: UIViewController {

    // MARK: Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private let userTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let addressStreetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let presenter: PostDetailsPresenterInput

    // MARK: View lifeCycle

    init(presenter: PostDetailsPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
        configureNavigationBar()
    }

    // MARK: - Setup UI
    private func setupUI() {

        view.backgroundColor = .systemBackground

        [titleLabel, bodyLabel, userTitleLabel, userNameLabel, userEmailLabel, companyNameLabel, addressStreetLabel].forEach {
            stackView.addArrangedSubview($0)
        }

        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])



    }

    private func configureNavigationBar() {
        navigationItem.title = Strings.postDetailsTitle.localized()

        let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPost))
        refreshButtonItem.tintColor = .label
        refreshButtonItem.tag = Tags.refresh.rawValue

        navigationItem.rightBarButtonItems = [refreshButtonItem]
    }

    @objc
    private func refreshPost() {
        presenter.viewDidLoad()
    }
}

// MARK: - PostDetailsPresenterOutput
extension PostDetailsViewController: PostDetailsPresenterOutput {

    func showPost(post: Post, user: User) {
        titleLabel.text = post.title.capitalized
        bodyLabel.text = post.body.capitalized

        userTitleLabel.text = Strings.authorTitle.localized()

        userNameLabel.text =  String(format: NSLocalizedString(Strings.usernameTitle.localized(), comment: ""), user.username )

        userEmailLabel.text = String(format: NSLocalizedString(Strings.emailTitle.localized(), comment: ""), user.email)

        if let street = user.address?.street {
            addressStreetLabel.text = String(format: NSLocalizedString(Strings.addressTitle.localized(), comment: ""), street)
        }

        if let companyName = user.company?.name {
            companyNameLabel.text = String(format: NSLocalizedString(Strings.companyTitle.localized(), comment: ""), companyName)
        }
    }
}
