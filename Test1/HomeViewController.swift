//
//  HomeViewController.swift
//  Test1
//
//  Created by eCOM-arjun.tp on 14/09/21.
//

import UIKit
import CoreData

var personList = [Person]()
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var firstLoad = true
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        table.delegate = self
        table.dataSource = self
        // MARK: FETCH DATA
        if firstLoad {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            
            do{
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results{
                    let personHere = result as! Person
                    personList.append(personHere)
                }
            }catch {
                print("Fetch Failed")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: PREPARE FOR SEQUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPerson" {
            let indexPath = table.indexPathForSelectedRow!
            let personDetail = segue.destination as? AddViewController
            let selectedPerson : Person!
            selectedPerson = personList[indexPath.row]
            personDetail!.selectedPerson = selectedPerson
            table.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    // MARK: NAVIGATE WITH SEQUE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editPerson", sender: self)
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = personList[indexPath.row]
        let cells = tableView.dequeueReusableCell(withIdentifier: "cell") as! PersonTableViewCell
        cells.setProdCell(obj: obj)
        return cells
    }
    
    
    // MARK: TABLE HEADER
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = "Name\t\tAge\t\tTerm Date\t\t\tFee"
        return header
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
    // MARK: DELETE FUNCTION
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action,
            view,completeHandler) in

                let personToRemove = personList[indexPath.row]

                context.delete(personToRemove)
                do{
                    try context.save()
                    personList.remove(at: indexPath.row)
                    tableView.reloadData()
                } catch {

                }
                Person.fetchRequest()
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
}
