import UIKit

class TimecardEmployeeTableViewCell: UITableViewCell, Nibable {

    var setHours: ((Double) -> Void)?
    
    @IBOutlet weak var employeeLabel: UILabel!
    @IBOutlet weak var hoursTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        hoursTextField.delegate = self
    }
}

extension TimecardEmployeeTableViewCell: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let number = Double(textField.text!) {
            setHours?(number)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        textField.endEditing(true)
        return false
    }
}
