import UIKit

extension ResultRemainingTableView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return numberOfItems?() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = itemProvider?(indexPath.row),
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: ResultRemainingTableCell.identifier,
                  for: indexPath
              ) as? ResultRemainingTableCell
        else {
            return UITableViewCell()
        }

        cell.updateUI(with: item)

        return cell
    }
}
