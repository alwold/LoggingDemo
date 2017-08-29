//
//  ButtonViewController.swift
//  LoggingDemo
//
//  Created by Al Wold on 8/28/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import UIKit
import os.log

enum ParseError: Error {
    case unexpectedType
    case nameMissingFromUser
}

class ButtonViewController: UIViewController {
    var users: [User]!
    
    @IBAction func loadSomeDataTapped(_ sender: Any) {
        let hud = UIAlertController(title: "Loading...", message: nil, preferredStyle: .alert)
        self.present(hud, animated: false)
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        os_log("Loading URL: %@", log: Logs.shared.defaultLog, type: .debug, url.absoluteString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    os_log("Loading JSON data", log: Logs.shared.defaultLog, type: .info)
                    let json = try JSONSerialization.jsonObject(with: data)
                    self.users = try self.parseJson(json: json)
                    self.dismiss(animated: false) {
                        self.performSegue(withIdentifier: "usersSegue", sender: sender)
                    }
                } catch {
                    os_log("Failed to load users: %@", log: Logs.shared.defaultLog, type: .error, error as NSError)
                    self.dismiss(animated: false) {
                        let alert = UIAlertController(title: "Error loading users", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: false)
                    }
                }
            } else {
                self.dismiss(animated: false) {
                    let alert = UIAlertController(title: "Error loading users", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: false)
                }
                if let error = error {
                    os_log("Error, no data from service: %@", log: Logs.shared.defaultLog, type: .error, error as NSError)
                } else {
                    os_log("Error, no data from service", log: Logs.shared.defaultLog, type: .error)
                }
            }
        }
            task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UsersViewController {
            destinationVC.users = users
        }
    }
    
    func parseJson(json: Any) throws -> [User] {
        if let json = json as? [Any] {
            var users = [User]()
            for userJson in json {
                if let userJson = userJson as? [String: Any] {
                    if let name = userJson["name"] as? String {
                        let user = User(name: name)
                        users.append(user)
                    } else {
                        throw ParseError.nameMissingFromUser
                    }
                } else {
                    throw ParseError.unexpectedType
                }
            }
            return users
        } else {
            throw ParseError.unexpectedType
        }
    }
}
