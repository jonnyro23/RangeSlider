import Foundation
import UIKit

public extension UIView {
    
    static var defaultLowerThumb: UIView {
        let thumb = UIView(frame: .init(origin: .zero, size: .init(width: 32, height: 32)))
        thumb.backgroundColor = .red
        thumb.isUserInteractionEnabled = false
        thumb.layer.borderWidth = 1
        thumb.layer.borderColor = UIColor.black.cgColor
        thumb.layer.cornerRadius = 16
        return thumb
    }
    
    static var defaultUpperThumb: UIView {
        let thumb = UIView(frame: .init(origin: .zero, size: .init(width: 32, height: 32)))
        thumb.backgroundColor = .red
        thumb.isUserInteractionEnabled = false
        thumb.layer.borderWidth = 1
        thumb.layer.borderColor = UIColor.black.cgColor
        thumb.layer.cornerRadius = 16
        return thumb
    }
}
