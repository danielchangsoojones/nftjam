//
//  DiscoverViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import UIKit

class DiscoverViewController: UIViewController {
    private var tableView: UITableView!
    private var montages: [MontageParse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .deepBlue
        setTableView()
    }
    
    private func setTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: DiscoverTableCell.self)
        view.addSubview(tableView)
        tableView.reloadData()
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return montages.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DiscoverTableCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 369
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 369
    }
}
