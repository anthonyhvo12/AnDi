//
//  CommentViewController.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit

protocol CommentViewControllerDelegate {
    func updateStarRate(value: Double, selectedIndex: Int)
}

class CommentViewController: UIViewController {
    
    @IBOutlet weak var report: UIButton!
    
    @IBOutlet weak var tableView: UITableView!

    var selectedIndex = -1
    var selectedValue = -1
    var selectedIndexPath: IndexPath!

    let arrTopics = ["Road width", "Traffic Density", "Traffic Lights", "Rule Obeying Status", "Police Activities"]
    let arrTopicIcons = ["road", "car", "traffic_light", "police", "police"]
    let arrEnumTopics: [CommentList] = [.roadwidth, .trafficdensity, .trafficlights, .ruleobeyingstatus, .authoritiesappearance]

    let arrDetailRoadWidth = ["Very narrow, hard to move", "Somehow narrow", "Medium", "Wide, easy to move", "Very wide"]
    let arrDetailTrafficDensity = ["Very dense, unable to move", "Somehow dense", "Medium", "Sparse, easy to move", "Very sparse"]
    let arrDetailTrafficLights = ["No traffic lights", "Long wait(60s and up)", "Medium wait(30s-60s)", "Short wait(20s-30s)", "Very short wait(20s or less)"]
    let arrDetailRuleObeyingStatus = ["Low awareness, not obeying rules", "Somehow low awareness", "Normal awareness", "Good awareness, obeying the rule", "Very good awareness"]
    let arrDetailAuthoritiesAppearance = ["Never show up", "Rarely show up", "Sometimes show up", "Usually show up", "Always show up adequately"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none

        report.layer.cornerRadius = 4.0
        report.clipsToBounds = true
        report.addTarget(self, action: #selector(clickReport), for: .touchUpInside)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func clickReport(){
        let alertViewController = UIAlertController(title: "Alert", message: "Report successfully!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            self.selectedIndex = -1
            self.selectedValue = -1
            self.tableView.reloadData()
        }
        alertViewController.addAction(okButton)
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTopics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as? CommentTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.tag = indexPath.row+1000
        cell.commentTitleLabel.text = arrTopics[indexPath.row]
        cell.starRateView.rating = Double(selectedValue+1)
        cell.commentImageView.image = UIImage(named: arrTopicIcons[indexPath.row])
        switch selectedIndex {
        case -1:
            cell.detailTitleLabel.text = ""
            break
        case 0:
            cell.detailTitleLabel.text = arrDetailRoadWidth[selectedValue]
            break
        case 1:
            cell.detailTitleLabel.text = arrDetailTrafficDensity[selectedValue]
            break
        case 2:
            cell.detailTitleLabel.text = arrDetailTrafficLights[selectedValue]
            break
        case 3:
            cell.detailTitleLabel.text = arrDetailRuleObeyingStatus[selectedValue]
            break
        case 4:
            cell.detailTitleLabel.text = arrDetailAuthoritiesAppearance[selectedValue]
            break

        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
}

extension CommentViewController: CommentViewControllerDelegate {
    func updateStarRate(value: Double, selectedIndex: Int) {
        self.selectedIndex = selectedIndex - 1000
        self.selectedValue = Int(value-1)
        tableView.beginUpdates()
        let indexPath = IndexPath(item: selectedIndex - 1000, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
}

