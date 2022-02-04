
import Foundation

class ViewModel {
    
    weak var viewController: ViewController?
    
    //MARK: data
    var timecard = Timecard(
        date: Date(),
        rows: [Row(hours: [0])],
        columns: [Column(costCode:
            CostCode(costCode: "cost-1234", jobCode: "job-1234", costCodeTitle: "my cost code", jobTitle: "my job")
        )]
    )
    
    //MARK: Setup / Controller Callbacks
    func viewControllerCreated() {
        viewController?.timecard = timecard
        
        viewController?.setHours = { hours, row, column in
            self.timecard.rows[row].hours[column] = hours
            self.viewController?.timecard = self.timecard
        }
    }
}
