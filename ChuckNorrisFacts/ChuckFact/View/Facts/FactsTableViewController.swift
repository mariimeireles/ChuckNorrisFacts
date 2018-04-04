//
//  FactsTableViewController.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 04/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import UIKit

class FactsTableViewController: UITableViewController {
    
    var facts: [FactModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.accessibilityIdentifier = "FactTableView"
        let nib = UINib(nibName: "FactCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "factCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.facts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactCell
        let fact = self.facts[indexPath.row]
        cell.fact = fact
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
