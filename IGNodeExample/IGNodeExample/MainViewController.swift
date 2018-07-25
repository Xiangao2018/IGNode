//
//  ViewController.swift
//  iPhoneGame
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 enjoy. All rights reserved.
//

import UIKit


fileprivate enum MainCellComponent {
    
    case resultTableViewCell
    case lineCell
    case actionCell(Int)
    
    var identifier: String {
        switch self {
        case .resultTableViewCell: return "resultTableViewCell"
        case .lineCell: return "lineCell"
        case .actionCell(_): return "actionCell"
        }
    }
    
    var height: CGFloat {
        switch self {
        case .resultTableViewCell:
            return 140
        case .lineCell:
            return 1.0
        case .actionCell(_):
            return 90.0
        }
    }
    
}


class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let controller = MainController()
    
    private var cellComponents: [MainCellComponent] {
        
        var components: [MainCellComponent] = [.resultTableViewCell, .lineCell]
        
        let rows = MainActionCell.numberOfRows(with: controller.actionInfos?.count ?? 0)
        
        for _ in 0..<rows {
            components.append(MainCellComponent.actionCell(MainActionCell.columns))
        }
        return components
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellComponent = self.cellComponents.object(at: indexPath.row) else { return UITableViewCell() }
        
        switch cellComponent {
        case .resultTableViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellComponent.identifier, for: indexPath) as! ResultTableViewCell
            
            
            return cell
        case .lineCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellComponent.identifier, for: indexPath)
            
            return cell
        case .actionCell(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellComponent.identifier, for: indexPath) as! MainActionCell
            cell.delegate = self
            let infos = MainActionCell.actionsGroup(with: controller.actionInfos!, forRow: indexPath.row - 2)
            
            cell.infos = infos
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellComponents.object(at: indexPath.row)?.height ?? 0
    }

}

extension MainViewController: MainActionCellDelegate {
    func actionCell(_ cell: MainActionCell, selectedAction info: MainActionInfo) {
        
        guard let action = info.action, let url = URL(string: action) else { return }
        
        AppDelegate.current.handleIGURL(url)
    }
}

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var correctRateLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
}

protocol MainActionCellDelegate {
    func actionCell(_ cell: MainActionCell, selectedAction info: MainActionInfo)
}

class MainActionCell: UITableViewCell {
    
    static let columns = 2
    
    var delegate: MainActionCellDelegate?
    
    @IBOutlet weak var collection: UICollectionView!
    
    var infos: [MainActionInfo]? {
        didSet {
            self.collection.reloadData()
        }
    }
    static func numberOfRows(with infosCount: Int) -> Int {
        return lround(Double(infosCount) / Double(columns))
    }
    
    static func actionsGroup(with actions: [MainActionInfo], forRow row: Int) -> [MainActionInfo] {
        let max = min(actions.count, (row + 1) * Int(columns))
        return Array(actions[(row * Int(columns))..<max])
    }
}

extension MainActionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let itemSpace = flowLayout.minimumInteritemSpacing
        
        let width = ceil((self.bounds.width - CGFloat(MainActionCell.columns - 1) * itemSpace) /  CGFloat(MainActionCell.columns))
        return CGSize(width: width, height: self.bounds.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainActionCell.columns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actionCollectionCell", for: indexPath) as! ActionCollectionCell
        
        cell.info = self.infos?.object(at: indexPath.row)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ActionCollectionCell, let info = cell.info else {
            return
        }
        delegate?.actionCell(self, selectedAction: info)
    }
}

class ActionCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var info: MainActionInfo? {
        didSet {
            self.titleLabel.text = info?.title
            self.subtitleLabel.text = info?.detail
            self.imageView.kf.setImage(with: URL(string: info?.imageName ?? ""))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
    }
}
