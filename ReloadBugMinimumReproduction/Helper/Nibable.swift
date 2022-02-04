
import Foundation
import UIKit

protocol Nibable: UIView {
    static var nibName:String { get }
    static var nibBundle: Bundle { get }
    
    static func createNib() -> UINib
}

extension Nibable {
    static var nibBundle: Bundle { .main }
    static var nibName: String { String(describing: self) }
    
    static func createNib() -> UINib {
        guard nibBundle.path(forResource: nibName, ofType: "nib") != nil else {
            fatalError("Unable to instantiate View Controller With Xib name \(nibName)")
        }
        return UINib(nibName: nibName, bundle: nibBundle)
    }
}
