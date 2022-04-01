//
//  DiscoverViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import UIKit

class DiscoverViewController: UIViewController {
    private var tableView: UITableView!
    private var montageDatas: [MontageData] = []
    private let dataStore = DiscoverDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .deepBlue
        setTableView()
        loadPhotos()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "NFTtube"
    }
    
    private func setMenuNavItem() {
        let img = UIImage(named: "settings")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                        style: .plain,
                        target: self,
                        action: #selector(settingsPressed))
    }
    
    @objc private func settingsPressed() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private func setTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(cellType: DiscoverTableCell.self)
        view.addSubview(tableView)
    }
    
    private func loadPhotos() {
        dataStore.loadPhotos { datas in
            self.montageDatas = datas
            self.tableView.reloadData()
        }
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return montageDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let montageData = montageDatas[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DiscoverTableCell.self)
        for (index, photo) in montageData.photos.enumerated() {
            if cell.thumbnailImgViews.indices.contains(indexPath.row) {
                cell.thumbnailImgViews[index].loadFromFile(photo.image)
            }
        }
        
        cell.montageTitleLabel.text = montageData.montage.title
        cell.creatorLabel.text = "By: " + montageData.montage.creator.codeName
        cell.ethValueLabel.text = String(montageData.montage.valueLocked) + "ETH"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 369
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 369
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let montage = montageDatas[indexPath.row].montage
        let montageVC = MontageViewController(montage: montage)
        self.navigationController?.pushViewController(montageVC, animated: true)
    }
}
