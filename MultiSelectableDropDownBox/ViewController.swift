//
//  ViewController.swift
//  MultiSelectableDropDownBox
//
//  Created by Arun Kumar.P on 3/8/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var singleSelectLabel: UILabel!
    @IBOutlet weak var singleSelectMandatoryLabel: UILabel!{
        didSet {
            singleSelectLabel.text = "Mandatory field"
        }
    }
    @IBOutlet weak var multiSelectLabel: UILabel!
    @IBOutlet weak var multiSelectMandatoryLabel: UILabel!{
        didSet {
            multiSelectMandatoryLabel.text = "Mandatory field"
        }
    }

    @IBOutlet weak var singleSelectView: UIView!
    @IBOutlet weak var singleSelectMandatoryView: UIView!
    @IBOutlet weak var multiSelectView: UIView!
    @IBOutlet weak var multiSelectMandatoryView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singleSelectButtonClicked(senderButton: UIButton){
        
        let myDataSource = ["Economy", "Geopolitics Geopolitics Geopolitics Geopolitics Geopolitics", "Industry","society"]
        
        multiSelector("Multiple Select", // Title - Optional
            dataSource: myDataSource,
            selectionType: .Single, // type of selection - Optinal (Default = .Single)
            isMandatory: false, // is that fiel is mandatory - Optional (Default = false)
            inViewController: self,
            atRect: senderButton.frame,
            inView: singleSelectView,
            arrowDirections: .Up, // Direction for iPad - Optinal
            animated: true)
        .singleCompletion = { (result: String!) -> Void in self.singleSelectLabel.text = result }
        
    }
    
    @IBAction func singleSelectMandatoryButtonClicked(senderButton: UIButton){
        
        let myDataSource = ["Economy", "Geopolitics Geopolitics Geopolitics Geopolitics Geopolitics", "Industry","society"]
        
        multiSelector("Multiple Select", // Title - Optional
            dataSource: myDataSource,
            selectionType: .Single, // type of selection - Optinal (Default = .Single)
            isMandatory: true, // is that fiel is mandatory - Optional (Default = false)
            inViewController: self,
            atRect: senderButton.frame,
            inView: singleSelectMandatoryView,
            arrowDirections: .Up, // Direction for iPad - Optinal
            animated: true)
            .singleCompletion = { (result: String!) -> Void in self.singleSelectMandatoryLabel.text = result }
        
    }
    
    @IBAction func multiSelectButtonClicked(senderButton: UIButton){
        
        let myDataSource = ["Economy", "Geopolitics Geopolitics Geopolitics Geopolitics Geopolitics", "Industry","society"]
        
        multiSelector("Multiple Select", // Title - Optional
            dataSource: myDataSource,
            selectionType: .Multi, // type of selection - Optinal (Default = .Single)
            isMandatory: false, // is that fiel is mandatory - Optional (Default = false)
            inViewController: self,
            atRect: senderButton.frame,
            inView: multiSelectView,
            arrowDirections: .Up, // Direction for iPad - Optinal
            animated: true)
        .multipleCompletion = { (result: [String]!) -> Void in self.multiSelectLabel.text = result.joinWithSeparator(", ") }
        
    }
    
    @IBAction func multiSelectMandatoryButtonClicked(senderButton: UIButton){
        
        let myDataSource = ["Economy", "Geopolitics Geopolitics Geopolitics Geopolitics Geopolitics", "Industry","society"]
        
        multiSelector("Multiple Select", // Title - Optional
            dataSource: myDataSource,
            selectionType: .Multi, // type of selection - Optinal (Default = .Single)
            isMandatory: true, // is that fiel is mandatory - Optional (Default = false)
            inViewController: self,
            atRect: senderButton.frame,
            inView: multiSelectMandatoryView,
            arrowDirections: .Up, // Direction for iPad - Optinal
            animated: true)
            .multipleCompletion = { (result: [String]!) -> Void in self.multiSelectMandatoryLabel.text = result.joinWithSeparator(", ") }
        
    }
    
}

