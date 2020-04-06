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
            seedNumberTextField.text = "\(seed.seedCount)"
            datePicker.setDate(seed.dateSown, animated: false)
        }
    }
    
    
    let seedNumberTextField: UITextField = {
        let txtfld = UITextField()
        txtfld.font = .preferredFont(forTextStyle: .title3)
        txtfld.textAlignment = .center
        txtfld.textColor = .systemBlue
        txtfld.autocorrectionType = .no
        txtfld.clearButtonMode = .always
        txtfld.keyboardType = .numberPad
        txtfld.clearsOnBeginEditing = true
        return txtfld
    }()
    
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.setDate(Date(), animated: false)
        return dp
    }()
    
    
    let changePlantButton: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.setTitle("Change Plant", for: .normal)
        btn.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        return btn
    }()
    
    
    func setupSubViews() {
        addSubview(seedNumberTextField)
        addSubview(datePicker)
        addSubview(changePlantButton)
        
        seedNumberTextField.centerXAnchor == self.centerXAnchor
        datePicker.horizontalAnchors == self.horizontalAnchors
        
        seedNumberTextField.sizeAnchors == CGSize(width: 120, height: 50)
        
        seedNumberTextField.topAnchor == self.topAnchor + 200
        datePicker.topAnchor == seedNumberTextField.bottomAnchor + 50
        
        changePlantButton.sizeAnchors == CGSize(width: 200, height: 50)
        changePlantButton.topAnchor == datePicker.bottomAnchor + 20
        changePlantButton.centerXAnchor == self.centerXAnchor
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
