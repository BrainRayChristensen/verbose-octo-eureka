import UIKit

class TimecardTableViewCell: UITableViewCell, Nibable {
    
    var setHours:((_ hours:Double, _ rowIndex: Int, _ columnIndex:Int) -> Void)? //value

    private var timecard:Timecard?
    private var columnIndex: Int?
    

    //MARK: IB Outlets
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var employeeTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        employeeTableView.register(TimecardEmployeeTableViewCell.createNib(), forCellReuseIdentifier: TimecardEmployeeTableViewCell.nibName)
    }
    
    func setupCellWithTimecard(timecard: Timecard?, columnIndex: Int) {
        self.timecard = timecard
        self.columnIndex = columnIndex
        
        var hours = 0.0
        for row in timecard?.rows ?? [] {
            hours += row.hours[columnIndex]
        }
        totalHoursLabel.text = "\(hours) hrs"
        
        employeeTableView.reloadData()
    }

}

//MARK: Table View Delegate
extension TimecardTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timecard?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimecardEmployeeTableViewCell.nibName, for: indexPath) as! TimecardEmployeeTableViewCell

        let hours = timecard?.rows[indexPath.row].hours
        cell.hoursTextField.text = String(hours?[columnIndex!] ?? 0)
        cell.setHours = { newHour in
            self.setHours?(newHour, indexPath.row, self.columnIndex!)
        }
        
        return cell
    }
}
