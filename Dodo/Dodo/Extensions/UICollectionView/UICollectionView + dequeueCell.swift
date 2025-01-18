//
//  UICollectionView + dequeueCell.swift
//  Dodo
//
//  Created by Tia M on 1/18/25.
//

import UIKit

extension UICollectionViewCell: Reusable{}

extension Reusable where Self: UICollectionViewCell {
  
  static var reuseId: String {
    String(describing: self)
  }
}

extension UICollectionView {
  
  func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
    register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
  }
    
  func dequeueCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }
    return cell
  }
}
