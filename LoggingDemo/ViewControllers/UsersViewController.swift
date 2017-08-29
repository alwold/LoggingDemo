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
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add User", message: "Please enter a name for the user", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(
            UIAlertAction(title: "Add", style: .default, handler:
                { action in
                    if let name = alert.textFields?.first?.text {
                        self.addUser(name: name)
                    } else {
                        os_log("User name not entered", log: Logs.shared.defaultLog, type: .info)
                        // show error
                    }
                }
            )
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: false)
    }
    
    func addUser(name: String) {
        os_log("Adding user: %@", log: Logs.shared.defaultLog, type: .debug, name)
        DispatchQueue.global(qos: .background).async {
            self.users.append(User(name: name))
            DispatchQueue.main.async {
                os_log("Triggering tableview refresh", log: Logs.shared.defaultLog, type: .debug)
                self.tableView.reloadData()
            }
        }
        DispatchQueue.global(qos: .background).async {
            self.randomSleep()
            os_log("Queueing user to be added to some data store", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Adding to data store", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Writing thingamabobs to filesystem", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Syncing write", log: Logs.shared.defaultLog, type: .debug)
        }
        DispatchQueue.global(qos: .background).async {
            self.randomSleep()
            os_log("Sending user to network service", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Looking up DNS entry", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Connecting to server", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("negotiating TLS", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Writing bytes", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Reading bytes", log: Logs.shared.defaultLog, type: .debug)
            self.randomSleep()
            os_log("Received 200 status, yay!", log: Logs.shared.defaultLog, type: .debug)
        }
    }
    
    func randomSleep() {
        usleep(arc4random_uniform(UInt32(USEC_PER_SEC/3)))
    }
}
