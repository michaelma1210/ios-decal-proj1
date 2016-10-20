//
//  TableViewController.swift
//  To-Do List v.2
//
//  Created by Michael Ma on 10/19/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var taskName: String?
    

    var taskAL = [taskClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                 sender: Any?){
        
        if segue.identifier == "stats" {
            var count = 0
            for eachTask in taskAL {
                if eachTask.checked == true {
                    count += 1
                }
            }
            if let statVC = segue.destination as? StatViewController {
                statVC.numTasks = count
            
            }
        }
        
    }
    
    @IBAction func doneUnwindToViewController(sender: UIStoryboardSegue) {

        let sourceViewController = sender.source as! AddViewController
        // Pull any data from the view controller which initiated the unwind segue.
        let taskName = sourceViewController.taskName.text
        if taskName != "" {
            insertNewObject(taskName!)
        }
        
    }
    
    @IBAction func cancelUnwindToViewController(sender: UIStoryboardSegue) {
        let sourceViewController = sender.source as! AddViewController
        
    }
    
    func deleteTask(tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)  {
        taskAL.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func checkTimes() {
        let currTime = NSDate()
        var index = 0
        for task in taskAL {
            if task.checked == true {

                let interval = currTime.timeIntervalSince(task.time as Date)
                if interval > 86400 {
                    taskAL.remove(at: index)
                    let indexPath = IndexPath(row: index, section: 0)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    index -= 1

                }
            }
            index += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkTimes()
    }

    
    func insertNewObject(_ taskName: String) {
        
        let timeNil = NSDate()
        
        
        taskAL.insert(taskClass(name: taskName, checked: false, time: timeNil), at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    

    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskAL.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
        
        let object = taskAL[indexPath.row]
    
        
        cell.textLabel!.text = object.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        let cell = tableView.cellForRow(at: didSelectRowAt)
        if cell?.accessoryType == UITableViewCellAccessoryType.none {
            cell?.accessoryType = .checkmark
            taskAL[didSelectRowAt.row].checked = true
            
            let timeStamp = NSDate()
            
            taskAL[didSelectRowAt.row].time = timeStamp
            
            
        } else {
            cell?.accessoryType = .none
            taskAL[didSelectRowAt.row].checked = false
        }
        tableView.deselectRow(at: didSelectRowAt, animated: true)
            
    }
    

    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskAL.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}
