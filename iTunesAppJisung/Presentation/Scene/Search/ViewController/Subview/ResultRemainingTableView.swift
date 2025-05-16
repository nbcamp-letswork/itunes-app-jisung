import Kingfisher
import SnapKit
import UIKit

final class ResultRemainingTableView: UIView {
    var itemProvider: ((Int) -> Media)?
    var numberOfItems: (() -> Int)?
    var shouldTap: (() -> Bool)?

    private let headerView = UIView()
    private let titleLabel = UILabel()
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if shouldTap?() != true {
            return super.hitTest(point, with: event)
        }

        let view = super.hitTest(point, with: event)

        if view is UIButton {
            return view
        }

        return nil
    }

    private func configureUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = ResultConstant.Remaining.backgroundCornerRadius

        titleLabel.font = .boldSystemFont(ofSize: ResultConstant.Remaining.titleFontSize)

        headerView.addSubview(titleLabel)

        tableView.register(ResultRemainingTableCell.self, forCellReuseIdentifier: ResultRemainingTableCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)

        [tableView]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(ResultConstant.Remaining.tableSpacing)
        }
    }

    func updateUI(title: String, isScrollEnabled: Bool) {
        titleLabel.text = title

        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()

        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: tableView.bounds.width,
            height: ResultConstant.Remaining.headerHeight
        )

        tableView.tableHeaderView = headerView
        tableView.isScrollEnabled = isScrollEnabled
    }
}
