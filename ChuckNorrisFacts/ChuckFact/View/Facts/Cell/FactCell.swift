//
//  FactCell.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 04/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {

    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var fact: FactModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let fact = fact else { return }
        fillOutlets(for: fact)
    }
    
    private func fillOutlets(for model: FactModel) {
        DispatchQueue.main.async {
            self.factLabel.text = model.message
            self.factLabel.font = model.messageFont
            self.categoryLabel.text = model.category
            self.categoryLabel.sizeToFit()
            self.categoryLabel.backgroundColor = model.categoryBackground
        }
    }
    
}
