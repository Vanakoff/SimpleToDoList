//
//  DetailsViewController.swift
//  SimpleToDoList
//
//  Created by Andrey Vanakoff on 20/06/2023.
//

import UIKit


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    var taskName: String?
    var taskDescription: String?
    var navigationTitle: String?
    // var done: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameLabel.text = taskName
        taskDescriptionLabel.text = taskDescription
        navigationItem.title = navigationTitle
    }
    
}
