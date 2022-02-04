import Foundation
import UIKit

class ViewController: UIViewController {
    
    //MARK: Ignore Below This
    //it's code for instantiating the view and doesn't apply to the problem
    static var xibBundle: Bundle { .main }
    static var xibName: String { String(describing: self) }

    private var viewModel: ViewModel?

    static func instantiateView(viewModel:ViewModel) -> Self {
        guard xibBundle.path(forResource: xibName, ofType: "nib") != nil else {
            fatalError("Unable to instantiate View Controller With Xib name \(xibName)")
        }
        
        let viewController = Self.init(nibName: xibName, bundle: xibBundle)
        viewController.viewModel = viewModel
        return viewController
    }
    
    override required init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MARK: Ignore Above This
    

    
    var timecard: Timecard? {didSet {
        if self.isViewLoaded {
            employeeTableView.reloadData()
            timecardTableView.reloadData()
        }
    }}

    var setHours: ((_ hours:Double, _ rowIndex: Int, _ columnIndex:Int) -> Void)?
    
    //MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var timecardTableView: UITableView!
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employeeTableView.reloadData()
        timecardTableView.reloadData()
    }
}

//MARK: UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        employeeTableView.register(EmployeeTableViewCell.createNib(), forCellReuseIdentifier: EmployeeTableViewCell.nibName)

        timecardTableView.dataSource = self
        timecardTableView.delegate = self
        timecardTableView.register(TimecardTableViewCell.createNib(), forCellReuseIdentifier: TimecardTableViewCell.nibName)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == timecardTableView{
            return timecard?.columns.count ?? 0
        } else if tableView == employeeTableView {
            return timecard?.rows.count ?? 0
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == employeeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.nibName, for: indexPath) as! EmployeeTableViewCell
            
            let hours = timecard?.rows[indexPath.row].hours.reduce(0, +) ?? 0
            cell.hoursLabel.text = "\(hours) hrs"
            
            return cell
        } else  if tableView == timecardTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TimecardTableViewCell.nibName, for: indexPath) as! TimecardTableViewCell
            
            cell.setupCellWithTimecard(timecard: timecard, columnIndex: indexPath.row)
            cell.setHours = { hours, rowIndex, columnIndex in
                self.setHours?(hours, rowIndex, columnIndex)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
