//
//  TableViewController.swift
//  SimpleToDoList
//
//  Created by Andrey Vanakoff on 20/06/2023.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var taskArray = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: String(describing: TaskTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: TaskTableViewCell.self))
        loadTasks()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskTableViewCell.self), for: indexPath) as! TaskTableViewCell
        
       // cell.textLabel?.text = taskArray[indexPath.row].name
        
        cell.taskCellLabel.text = taskArray[indexPath.row].name
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            
            detailsVC.navigationTitle = taskArray[indexPath.row].name
            
          //  detailsVC.taskName = taskArray[indexPath.row].name
            detailsVC.taskDescription = taskArray[indexPath.row].taskDescription
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    //MARK: - Add New Task
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let settingsVC = segue.source as? SettingsViewController else { return }
        
        let newTask = Task(context: self.context)
        newTask.name = settingsVC.nameTextField.text
        
        if newTask.name == "" {
            newTask.name = "new task"
        }
        
        newTask.taskDescription = settingsVC.descriptionTextView.text
        
        if newTask.taskDescription == "" {
            newTask.taskDescription = "no description"
        }
        
        taskArray.append(newTask)
        saveTask()
        tableView.reloadData()
    }
    
    
    func loadTasks() {
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            taskArray = try context.fetch(request)
        } catch {
            print("Cannot fetch Tasks Data, \(error)")
        }
        tableView.reloadData()
    }
    
    
    func saveTask() {
        do {
            try context.save()
        } catch {
            print("Cannot save a New Task, \(error)")
        }
        tableView.reloadData()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    //MARK: - Delete Task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            context.delete(taskArray[indexPath.row])
            taskArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveTask()
        } 
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
