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
    
    var seedling: Seedling! {
        didSet {
            seedlingNameLabel.text = "\(seedling.genus) \(seedling.species)"
            seedlingDateLabel.text = seedling.dateSown.description
            numberOfSeedsLabel.text = "\(seedling.numberOfSeeds)"
        }
    }
    
    
    private let seedlingNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline)
        return lbl
    }()
    
    private let seedlingDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        return lbl
    }()
    
    private let numberOfSeedsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.textAlignment = .right
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
        addSubview(seedlingDateLabel)
        addSubview(numberOfSeedsLabel)
        
        numberOfSeedsLabel.verticalAnchors == self.verticalAnchors
        numberOfSeedsLabel.trailingAnchor == self.trailingAnchor - 35
        numberOfSeedsLabel.widthAnchor <= 40
        
        seedlingNameLabel.trailingAnchor == numberOfSeedsLabel.leadingAnchor
        seedlingNameLabel.topAnchor == self.topAnchor
        seedlingNameLabel.leadingAnchor == self.leadingAnchor + 10
        
        seedlingDateLabel.trailingAnchor == numberOfSeedsLabel.leadingAnchor
        seedlingDateLabel.leadingAnchor == self.leadingAnchor + 10
        seedlingDateLabel.topAnchor == seedlingNameLabel.bottomAnchor
        seedlingDateLabel.bottomAnchor == self.bottomAnchor
    }

}



// Figure out how to use other than default UITableViewCell
