//
//  MultiSelectionController.swift
//  MultiSelectableDropDownBox
//
//  Created by Arun Kumar.P on 3/8/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

import UIKit

enum DropDownSelectionType {
    case Single
    case Multi
}

func multiSelector(title: String = "",
    dataSource: [String],
    selectionType: DropDownSelectionType! = .Single,
    isMandatory: Bool = false,
    inViewController currentViewController: UIViewController?,
    atRect:CGRect, inView: UIView,
    arrowDirections:UIPopoverArrowDirection = .Up,
    animated:Bool) -> MultiSelectionController {
        
        let multiSelectorViewController = MultiSelectionController(dataSource: dataSource, selectionType: selectionType, isMandatory: isMandatory)
        let navController = UINavigationController(rootViewController: multiSelectorViewController)
        let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: multiSelectorViewController, action: "close")
        
        multiSelectorViewController.title = title
        multiSelectorViewController.navigationItem.rightBarButtonItem = doneButton
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            multiSelectorViewController.parentController = navController
            currentViewController!.presentViewController(navController, animated: animated, completion: nil)
            return multiSelectorViewController
            
        case .Pad:
            
            let popoverController = UIPopoverController(contentViewController: navController)
            multiSelectorViewController.parentController = popoverController
            popoverController.setPopoverContentSize(CGSize(width: 320, height: 216), animated: animated)
            popoverController.presentPopoverFromRect(atRect, inView: inView, permittedArrowDirections: arrowDirections, animated: animated)
            return multiSelectorViewController
        case .TV:
            return multiSelectorViewController
        case .Unspecified:
            return multiSelectorViewController
        }
        
}

class MultiSelectionController: UITableViewController {
    
    static let kMultiSelectionCellIdentifier = "MultiSelectionCellIdentifier"
    
    typealias SingleResult = (String!) -> Void
    typealias MultipleResult = ([String]!) -> Void
    
    var dataSource: [String]?
    var selectedItems = [String]()
    var parentController: AnyObject?
    var selectionType: DropDownSelectionType = .Single
    var isMandatory:Bool = true
    
    var singleCompletion = { (result: String!) -> Void in NSLog("selected Items = \(result)") }
    var multipleCompletion = { (result: [String]!) -> Void in NSLog("selected Items = \(result)") }
    
    init(dataSource: [String], selectionType: DropDownSelectionType!, isMandatory: Bool){
        super.init(style: .Plain)
        self.dataSource = dataSource
        self.selectedItems =  selectionType == .Multi ? dataSource : isMandatory && dataSource.count > 1 ? [dataSource[0]] : [String]()
        self.isMandatory = isMandatory
        self.selectionType = selectionType
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Need this to prevent runtime error:
    // fatal error: use of unimplemented initializer 'init(nibName:bundle:)'
    // for class 'TestViewController'
    // I made this private since users should use the no-argument constructor.
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        self.tableView.registerNib( UINib(nibName: "MultiSelectionDynamicCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: MultiSelectionController.kMultiSelectionCellIdentifier)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(){
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            if let navController = parentController as? UINavigationController{
                navController.dismissViewControllerAnimated(true, completion: nil)
            }
            return
        case .Pad:
            
            if let popoverController = parentController as? UIPopoverController{
                popoverController.dismissPopoverAnimated(true)
            }
            
            return
        case .TV:
            return
        case .Unspecified:
            return
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (section == 0) ? (selectionType == .Single) ? 0 : 1 : dataSource!.count;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(MultiSelectionController.kMultiSelectionCellIdentifier, forIndexPath: indexPath) as! MultiSelectionDynamicCell
        
        cell.selectionStyle = .None
        
        switch indexPath.section {
        case 0:
            cell.dynamicTitleLabel?.text = "All"
            cell.selectionImageView.hidden = (dataSource!.count != selectedItems.count)
        case 1:
            cell.dynamicTitleLabel?.text = dataSource![indexPath.row]
            cell.selectionImageView.hidden = !(selectedItems.contains(dataSource![indexPath.row]))
        default: break
            
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        func addItem(){
            selectedItems.append(dataSource![indexPath.row])
        }
        
        func removeItem(){
            selectedItems.removeObject(dataSource![indexPath.row])
        }
        
        var isContain: Bool{
            return selectedItems.contains(dataSource![indexPath.row])
        }
        
        switch indexPath.section {
        case 0:
            if dataSource!.count > selectedItems.count {
                selectedItems = dataSource!;
            }else if isMandatory{
                selectedItems = [dataSource![0]];
            }else{
                selectedItems = [String]()
            }
        case 1:
            
            switch selectionType{
            case .Single:
                if selectedItems.count == 1 && isMandatory && isContain {
                    return
                }else{
                    if isContain {
                        removeItem()
                    }else{
                        selectedItems = [dataSource![indexPath.row]]
                    }
                }
            case .Multi:
                if !isContain {
                    addItem()
                }else if selectedItems.count == 1 && isMandatory{
                    return
                }else {
                    removeItem()
                }
                
            }
            
        default: break;
            
        }
        self.tableView.reloadData()
        
        updateResult() // delegate the result using closure method in swift
        
    }
    
    func close(sender: UIButton!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK - Result Functions
    
    func updateResult() {
        
        switch selectionType{
        case .Single:
            self.singleCompletion(self.selectedItems.count > 0 ? selectedItems[0] : "")
        case .Multi:
            self.multipleCompletion(self.selectedItems)
        }
        
    }
    
}

