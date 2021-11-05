//
//  AddViewController.swift
//  Test1
//
//  Created by eCOM-arjun.tp on 14/09/21.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var tution: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePick: UITextField!
    
    var selectedPerson: Person? = nil
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Person Details"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if selectedPerson != nil {
            tution.text = String(Double(selectedPerson!.fee))
            age.text = String(Int32(selectedPerson!.age))
            name.text = selectedPerson?.name
            var abc = String()
            abc = String(selectedPerson!.termDate)
            datePicker.date = (dateFormatter.date(from: abc))!
            datePick.text = selectedPerson!.termDate
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datePick.inputView = datePicker
        datePicker.datePickerMode = .date
        datePick.text = dateFormatter.string(from: datePicker.date)
        // Do any additional setup after loading the view.
    }
  
    @IBAction func saveUser(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedPerson == nil){
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
            let newPerson = Person(entity: entity!, insertInto: context)
            
            newPerson.fee = Double(tution.text!)!
            newPerson.age = Int32(age.text!)!
            newPerson.name = String(name.text!)
            newPerson.termDate = dateFormatter.string(from: datePicker.date)
            
            do{
                try context.save()
                personList.append(newPerson)
                navigationController?.popViewController(animated: true)
            } catch{
                print("Context Save Error")
            }
        } else{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            
            do{
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results{
                    let personHere = result as! Person
                    if personHere == selectedPerson {
                        personHere.age = Int32(age.text!)!
                        personHere.fee = Double(tution.text!)!
                        personHere.name = name.text!
                        personHere.termDate = datePick.text!
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }catch {
                print("Fetch Failed")
            }
        }
        
        
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        datePick.text = dateFormatter.string(from: datePicker.date)
    }
    
}
