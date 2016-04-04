//
//  ItemDetailViewController..swift
//  Checklists
//
//  Created by Ankit on 01/04/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?

    @IBOutlet weak var checklistItemText: UITextField!

    @IBOutlet weak var saveItem: UIBarButtonItem!
        

    @IBAction func cancel(sender: UIBarButtonItem) {
        
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func save(sender: AnyObject) {
        if let item = itemToEdit {
            item.text = checklistItemText.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = checklistItemText.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            checklistItemText.text = item.text
        }
    }
    override func tableView(tableView: UITableView,
        willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checklistItemText.becomeFirstResponder()
    }
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(
        range, withString: string)
        saveItem.enabled = (newText.length > 0)
        return true
    }
}
