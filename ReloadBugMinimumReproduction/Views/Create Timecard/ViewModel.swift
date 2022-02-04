
import Foundation

class ViewModel {
    
    weak var viewController: ViewController?
    
    func instantiate() -> ViewController {
        let vc = ViewController.instantiateView(viewModel: self)
        viewController = vc
        viewControllerCreated()
        return vc
    }
    
    //MARK: data
    var timecard = Timecard(
        date: Date(),
        rows: [Row(user: DummyData.users[0], hours: [0])],
        columns: [Column(costCode: DummyData.costCodes[0])]
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
