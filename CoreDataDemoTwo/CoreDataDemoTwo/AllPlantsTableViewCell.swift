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
    
//    var seedling: Seedling! {
//        didSet {
//            print("new seedling: \(seedling.genus) \(seedling.species)")
//            seedlingNameLabel.text = "\(seedling.genus) \(seedling.species)"
//        }
//    }
    
    
    private let seedlingNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 16)
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
        seedlingNameLabel.edgeAnchors == self.edgeAnchors
    }

}
