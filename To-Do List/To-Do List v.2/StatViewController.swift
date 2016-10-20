//
//  StatViewController.swift
//  To-Do List v.2
//
//  Created by Michael Ma on 10/19/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {

    @IBOutlet var numOfTasksCompleted: UILabel!
    var numTasks = 0
    
    override func viewDidLoad() {
        numOfTasksCompleted.text = String(numTasks)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
