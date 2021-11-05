//
//  PersonTableViewCell.swift
//  Test1
//
//  Created by eCOM-arjun.tp on 15/09/21.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var termDate: UILabel!
    @IBOutlet weak var termFee: UILabel!
    
    var abc = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProdCell(obj:Person){
        
        name.text = obj.name
        age.text = String(Int32(obj.age))
        termDate.text = obj.termDate
        termFee.text = String(Double(obj.fee))
    }
    
    func setHeader()
    {
        name.text = "Name"
        age.text = "Age"
        termDate.text = "Term Date"
        termFee.text = "Term Fee"
    }

}
