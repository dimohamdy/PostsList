//
//  PostsTableViewDataSource.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

final class PostsTableViewDataSource: UITableViewDiffableDataSource<TableViewSectionType, Post>, UITableViewDelegate {

    private struct CellHeightConstant {
        static let heightOfPostCell: CGFloat = 50
        static let heightOfHistoryHeader: CGFloat = 50
    }

    weak var presenterInput: PostsListPresenterInput?

    var tableSections: [TableViewSectionType] = [] {
        didSet {
            self.applySnapshot()
        }
    }

    init(tableView: UITableView, presenterInput: PostsListPresenterInput?, tableSections: [TableViewSectionType]) {
        super.init(tableView: tableView) { (tableView, indexPath, postModel) -> UITableViewCell? in
            guard let cell: PostTableViewCell = tableView.dequeueReusableCell(for: indexPath) else {
                assertionFailure("Failed to dequeue \(TableViewSectionType.self)!")
                return UITableViewCell()
            }
            cell.accessibilityIdentifier = "\(AccessibilityIdentifiers.PostsList.cellId).\(indexPath.row)"
            cell.configCell(postModel: postModel)
            return cell
        }
        self.tableSections = tableSections
        self.presenterInput = presenterInput
        self.applySnapshot(animated: false, animatingDifferences: false)
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

    private func applySnapshot(animated: Bool = true, animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSectionType, Post>()
        for section in tableSections {
            snapshot.appendSections([section])
            switch section {
            case .online(let posts), .local(let posts):
                snapshot.appendItems(posts, toSection: section)
            }
        }
        self.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
