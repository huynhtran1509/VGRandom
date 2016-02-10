//
//  AddPersonTableViewController.swift
//  VaingloryRandom
//
//  Created by Htain Lin Shwe on 31/12/15.
//  Copyright © 2015 comquas. All rights reserved.
//

import UIKit

class AddPersonTableViewController: UITableViewController {

    var ppl:[String] = [String]()

    let usrDefault = NSUserDefaults.standardUserDefaults()
    var selectedPpl:[Bool] = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadData();

    }
    
    @IBAction func add() {
        
        addOrEdit(false,indexPath: nil)

    }
    
    func editAtIndexPath(name:String,indexPath:NSIndexPath) {
        
        self.ppl[indexPath.row] = name
        self.updateUserDefault()
        
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        
        
    }
    
    func addOrEdit(edit:Bool,indexPath:NSIndexPath?) {
        
        var title = "Add"
        var txtBox = ""

        if(edit) {
            title = "Edit"
            if let ip = indexPath {
                let cell = tableView.cellForRowAtIndexPath(ip)
                txtBox = (cell?.textLabel?.text)!
            }
        }
        
        let alertController = UIAlertController(title: title, message: "Please enter the name:", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (_) in
            let field = alertController.textFields![0]
            if let txt = field.text {
                // store your data
                if(!edit) {
                    self.addPerson(txt)
                }
                else {
                    if let ip = indexPath {
                        self.editAtIndexPath(txt, indexPath: ip)
                    }
                }
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = txtBox
            textField.placeholder = "Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func loadData() {
        
        
        guard let pplList = usrDefault.stringArrayForKey(PEOPLE_LIST) else {
            return;
        }
        
        self.ppl = pplList

        
        guard let selected = usrDefault.objectForKey(SELECTED_PEOPLE_LIST) as? [Bool] else {
            return;
        }
        
        self.selectedPpl = selected
        
    }
    
    func addPerson(person:String) {
        
        self.ppl.append(person);
        self.selectedPpl.append(true);
        updateUserDefault()
        
    }
    
    func updateUserDefault(reload:Bool = true) {
        usrDefault.setObject(self.ppl, forKey: PEOPLE_LIST)
        usrDefault.setObject(self.selectedPpl, forKey: SELECTED_PEOPLE_LIST)
        usrDefault.synchronize()
        
        if(reload) {
            self.tableView.reloadData()
        }
    }
    
    func updateSelectedPplList() {
        usrDefault.setObject(self.selectedPpl, forKey: SELECTED_PEOPLE_LIST)
        usrDefault.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ppl.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var c = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")

        if c == nil {
            c = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        
        guard let cell = c else {
            return c!
        }
        

        // Configure the cell...
        cell.textLabel?.text = self.ppl[indexPath.row]
        
        if (self.selectedPpl[indexPath.row]) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell

        

       
        

    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    func deletePeopleAtIndexPath(indexPath: NSIndexPath) {
        self.ppl.removeAtIndex(indexPath.row)
        self.updateUserDefault(false)
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
           self.deletePeopleAtIndexPath(indexPath)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedPpl[indexPath.row] = !self.selectedPpl[indexPath.row]
        self.updateSelectedPplList()
        tableView .reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
         
            self.tableView.setEditing(false, animated: true)
            self.addOrEdit(true,indexPath: indexPath)
            
        }
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") {(action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
        
            self.tableView.setEditing(false, animated: true)
            self.deletePeopleAtIndexPath(indexPath)
            
        }
        
        return [deleteAction,editAction]
        
    }
    /*
    
    - (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"More" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
    // maybe show an action sheet with more options
    [self.tableView setEditing:NO];
    }];
    moreAction.backgroundColor = [UIColor lightGrayColor];
    
    UITableViewRowAction *blurAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Blur" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
    [self.tableView setEditing:NO];
    }];
    blurAction.backgroundEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
    [self.objects removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return @[deleteAction, moreAction, blurAction];
    } */
}
