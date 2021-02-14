//
//  UITableView+Helper.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit
import Foundation

// MARK: - Register

extension UITableView {
    /// Registers a nib object containing a cell with the table view under a specified identifier.
    /// Cell class name will be used as nib name and default reuse identifier.
    /// - Parameters:
    ///   - nibForClass: A cell class which is used for nib name and cell identifier
    ///   - identifier: Reuse identifier for cell. Will have cell class name as default value.
    ///   - bundle: The bundle in which to search for nib file. If nil, it will look into main bundle.
    func register<Cell: UITableViewCell>(nibForClass: Cell.Type,
                                         forCellReuseIdentifier identifier: String = String(describing: Cell.self),
                                         bundle: Bundle? = nil) {
        let nib = UINib(nibName: String(describing: Cell.self), bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
}


// MARK: - Dequeue

extension UITableView {
    /// Returns a dequeued table view cell with given cell type and reuse identifier.
    /// Cell class name will be used as nib name and default reuse identifier.
    /// - Parameters:
    ///   - cellType: Cell class to be dequeued
    ///   - indexPath: Index path for cell
    ///   - identifier: Reuse identifier for cell. Will have cell class name as default value.
    /// - Returns: A dequeued cell of same type as provide cell class.
    func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type,
                                                    for indexPath: IndexPath,
                                                    withIdentifier identifier: String = String(describing: Cell.self)) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue table view cell of type \(cellType) with identifier \(identifier)")
        }
        
        return cell
    }
}
