//
//  CustomStaticTableHeadersViewController.swift
//  CustomStaticTableHeadersDemo
//
//  Created by Steve Cochran on 6/24/17.
//  Copyright © 2017 Example, Inc. All rights reserved.
//

import UIKit

class CustomStaticTableHeadersViewController: UITableViewController {

  // track current section visibility
  var sectionVisibility = [true, true, true]

  
  /*  willDisplayHeaderView is used to customize the existing header view. 
      The other options is viewForHeaderInSection, although this function 
      does not provide access to the system default appearence as the entire
      view is provided by you. This could be from a nib or defined in code. */
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    
    let header = view as! UITableViewHeaderFooterView
    
    // MARK:  Default Table Header Appearance
    // system group header defaults can be accessed here from view
    // allows for customizing while matching any future UI changes
    // on iOS 10.2: (109, 109, 114, 255)
    let headerLabelTextColor: UIColor = header.textLabel!.textColor
    // on iOS 10.2: San Fransisco, 13pt, .uppercased
    let headerLabelFont: UIFont = header.textLabel!.font
    // background color available through UIColor.groupTableViewBackground
  
    
    // MARK: Adding buttons
    /*  Care must be taken when adding buttons because header cells
        seem to be reused even in a static table. To work around this,
        we must check to see if we have already added a button to this view.

        Another option would be deleting the custome buttons in
        didEndDisplayingHeaderView every time, but this defeats the purpose of
        reusing cells in TableViews.
    */
    
    // References for existing or new buttons
    var selectButton: UIButton? = nil
    var toggleButton: UIButton? = nil
  
    /*  Check to see if a button has already been added to
          avoid problems when cells are reused
        If adding multple buttons, some method to identify them is required.
          In this example, one button has a title, the other does not. Tags
          are not used as they are set to the current section. Another option would be
          using a class variable could be used for the current section and then tags
          could ID the button.
    */
    for i in 0..<view.subviews.count {
      if view.subviews[i] is UIButton {
        let tempButton = view.subviews[i] as? UIButton
        if (tempButton?.currentTitle != "") {
          selectButton = view.subviews[i] as? UIButton
        } else {
          toggleButton = view.subviews[i] as? UIButton
        }
      }
    }
    
    // No buttons exist, create new ones
    if selectButton == nil {
      selectButton = UIButton(type: .system)
      header.addSubview(selectButton!)
      toggleButton = UIButton(type: .system)
      header.addSubview(toggleButton!)
    }
    
    // Configure buttons
    selectButton?.frame = CGRect(x: view.frame.size.width - 85, y: view.frame.size.height - 28, width: 77, height: 26)
    selectButton?.tag = section
    selectButton?.setTitle("SELECT ALL", for: .normal)
    selectButton?.titleLabel?.font = UIFont(descriptor: headerLabelFont.fontDescriptor, size: 11)
    selectButton?.contentHorizontalAlignment = .right;
    selectButton?.setTitleColor(self.view.tintColor, for: .normal)
    selectButton?.addTarget(self, action: #selector(self.selectAllInSection), for: .touchUpInside)
    
    
    /*  toggleButton is a transparant button overlaying the section header.
 
        Getting frame of the headerLabel gives unexpected results.
        The label text can be accessed, but frame size doesn't match,
        so using entire width minus select button width.
    
        To see this button, the following line can be uncommented */
    
    // toggleButton?.backgroundColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.05)
    toggleButton?.frame = CGRect(x: 16, y: view.frame.size.height - 28, width: view.frame.size.width - 90, height: 26)
    toggleButton?.tag = section
    toggleButton?.setTitle("", for: .normal)
    toggleButton?.addTarget(self, action: #selector(self.toggleSectionRows), for: .touchUpInside)
    
  }
  
  func selectAllInSection(_ sender: UIButton) {
    let section = sender.tag
    
    // get number of rows
    let numRows = self.tableView.numberOfRows(inSection: section)
    
    // loop through each row in section
    var currIndexPath: NSIndexPath? = nil
    var cell: UITableViewCell? = nil
    for i in 0..<numRows {
      currIndexPath = NSIndexPath(row: i, section: section)
      cell = self.tableView.cellForRow(at: currIndexPath as! IndexPath)
      
      // toggle checkmark
      if (sender.titleLabel?.text == "SELECT ALL") {
        cell?.accessoryType = .checkmark
      } else {
        cell?.accessoryType = .none
      }
    }
    
    // change button title to reflect status
    if (sender.titleLabel?.text == "SELECT ALL") {
      sender.setTitle("SELECT NONE", for: .normal)
    } else {
      sender.setTitle("SELECT ALL", for: .normal)
    }
  }
  
  
  // toggle individual row checkmarks
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      if cell.accessoryType == .none {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  // show/hide rows in a given selection
  func toggleSectionRows(_ sender: UIButton) {
    let section = sender.tag
    
    if (sectionVisibility[section]) {
      sectionVisibility[section] = false
    } else {
      sectionVisibility[section] = true
    }
    
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    // change row height based on sectionVisibility
    let section = indexPath.section
    
    if (sectionVisibility[section] == false) {
      return 0
    } else {
      return 44
    }
  }


}

