//
//  EditSowingInformationView.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/3/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit
import Anchorage

class EditSowingInformationView: UIView {
    
    var seed: Seed! {
        didSet {
            datePicker.setDate(seed.dateSown, animated: false)
            seedNumberTextField.text = "\(seed.seedCount)"
        }
    }
    
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.setDate(Date(), animated: false)
        return dp
    }()
    
    
    let seedNumberTextField: UITextField = {
        let txtfld = UITextField()
        txtfld.font = .preferredFont(forTextStyle: .body)
        txtfld.textAlignment = .center
        txtfld.textColor = .systemBlue
        txtfld.autocorrectionType = .no
        txtfld.clearButtonMode = .always
        txtfld.keyboardType = .numberPad
        txtfld.clearsOnBeginEditing = true
        return txtfld
    }()
    
    
    func setupSubViews() {
        addSubview(seedNumberTextField)
        addSubview(datePicker)
        
        seedNumberTextField.centerXAnchor == self.centerXAnchor
        datePicker.horizontalAnchors == self.horizontalAnchors
        
        seedNumberTextField.sizeAnchors == CGSize(width: 120, height: 50)
        
        seedNumberTextField.topAnchor == self.topAnchor + 200
        datePicker.topAnchor == seedNumberTextField.bottomAnchor + 50
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
