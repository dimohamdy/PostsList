//
//  PostsTableViewDataSource.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

final class PostsTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableSections: [TableViewSectionType] = []

    weak var presenterInput: PostsListPresenterInput?

    private struct CellHeightConstant {
        static let heightOfPostCell: CGFloat = 50
        static let heightOfHistoryHeader: CGFloat = 50
    }

    init(presenterInput: PostsListPresenterInput?, tableSections: [TableViewSectionType]) {
        self.tableSections = tableSections
        self.presenterInput = presenterInput
    }

    // MARK: - UITableView view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = tableSections[section]
        switch section {
        case .online(let posts), .local(let posts):
            return posts.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = tableSections[indexPath.section]
        switch section {
        case .online(let posts), .local(let posts):
            if let cell: PostTableViewCell = tableView.dequeueReusableCell(for: indexPath) {
                cell.configCell(postModel: posts[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterInput?.open(indexPath: indexPath)

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CellHeightConstant.heightOfPostCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CellHeightConstant.heightOfHistoryHeader
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: GeneralTableHeader.identifier) as? GeneralTableHeader else {
            return nil
        }
        let section = tableSections[section]
        switch section {
        case .online:
            headerCell.headerLabel.text = Strings.onlineTitle.localized()
        case .local:
            headerCell.headerLabel.text = Strings.localTitle.localized()
        }

        return headerCell
    }
}
