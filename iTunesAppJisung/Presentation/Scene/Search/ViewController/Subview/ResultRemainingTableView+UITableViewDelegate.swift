import UIKit

extension ResultRemainingTableView: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        ResultConstant.Remaining.tableCellHeight
    }
}
