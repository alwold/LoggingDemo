//
//  UsersViewController.swift
//  LoggingDemo
//
//  Created by Al Wold on 8/28/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import UIKit
import os.log

class UsersViewController: UITableViewController {
    var users: [User]!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        os_log("Returning number of rows in section: %d", log: Logs.shared.defaultLog, type: .debug, users.count)
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        os_log("Setting cell for row %d to %@", log: Logs.shared.defaultLog, type: .debug, indexPath.row, users[indexPath.row].name)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
