//
//  AllPlantsTableViewCell.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/1/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit
import Anchorage

class AllPlantsTableViewCell: UITableViewCell {
    
    var plant: Plant! {
        didSet {
            seedlingNameLabel.text = "\(plant.genus) \(plant.species)"
            seedlingCountLabel.text = "\(plant.seeds.count)"
        }
    }
    
    
    private let seedlingNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .title2)
        return lbl
    }()
    
    
    private let seedlingCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body)
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupSubviews() {
        addSubview(seedlingNameLabel)
        addSubview(seedlingCountLabel)
        
        seedlingNameLabel.verticalAnchors == self.verticalAnchors
        seedlingCountLabel.verticalAnchors == self.verticalAnchors
        
        seedlingNameLabel.leadingAnchor == self.leadingAnchor + 10
        seedlingNameLabel.trailingAnchor == seedlingCountLabel.leadingAnchor
        seedlingCountLabel.trailingAnchor == self.trailingAnchor - 40
        seedlingCountLabel.widthAnchor <= 50
    }

}
