//
//  MenuViewController.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let menuTitles = ["Home", "My profile", "Points", "Log out", "Setting", "Help"]
    let menuImages = ["home", "profile", "point", "logout", "setting", "help"]
    let cellIdentifier = "MenuTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MenuTableViewCell else { return UITableViewCell() }
        cell.menuTitleLabel.text = menuTitles[indexPath.row]
        cell.menuImageView.image = UIImage(named: menuImages[indexPath.row])!.withRenderingMode(.alwaysTemplate)
        cell.menuImageView.tintColor = UIColor(rgb: kColor)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.frostedViewController.hideMenuViewController()
    }
}
