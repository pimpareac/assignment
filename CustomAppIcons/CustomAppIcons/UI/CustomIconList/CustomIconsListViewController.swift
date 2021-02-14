//
//  CustomIconsListViewController.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit

class CustomIconsListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(nibForClass: CustomIconsTableViewCell.self)
    }    
}

// MARK: - Table view data source

extension CustomIconsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CustomIconsTableViewCell.self, for: indexPath)
        return cell
    }
}
