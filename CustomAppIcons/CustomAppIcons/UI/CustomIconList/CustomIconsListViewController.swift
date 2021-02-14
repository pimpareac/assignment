//
//  CustomIconsListViewController.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Combine
import UIKit

class CustomIconsListViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var viewModel: IconListViewModel = {
        IconListViewModel()
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(nibForClass: CustomIconsTableViewCell.self)
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSpinnerView()
        
        viewModel.fetchAppIcons {
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        
        viewModel.$isLoading.sink { [weak self] (isLoading) in
            self?.setSpinnerState(loading: isLoading)
        }
        .store(in: &cancellables)
        
        viewModel.$errorMessage.sink { [weak self] (errorMessage) in
            self?.setError(message: errorMessage)
        }
        .store(in: &cancellables)
        
        viewModel.$appIconList.sink { [weak self] (iconlist) in
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
    }
    
    // MARK: - UI Handling
    
    private lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private func addSpinnerView() {
        if spinner.superview == nil, let superView = tableView.superview {
            superView.addSubview(spinner)
            superView.bringSubviewToFront(spinner)
            
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        }
    }
    
    private func setSpinnerState(loading: Bool) {
        guard loading == false else {
            spinner.startAnimating()
            return
        }
        
        spinner.stopAnimating()
    }
    
    private func setError(message: String?) {
        guard let message = message else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            return
        }
        
        let noDataLabel = UILabel()
        noDataLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        noDataLabel.adjustsFontForContentSizeCategory = true
        noDataLabel.text =  message
        noDataLabel.textAlignment = .center
        tableView.backgroundView  = noDataLabel
        tableView.separatorStyle = .none
    }
}

// MARK: - Table view data source

extension CustomIconsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.appIconList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CustomIconsTableViewCell.self, for: indexPath)
        cell.updateCell(with: viewModel.appIconList[indexPath.row])
        return cell
    }
}
