import Foundation
import UIKit

public struct TrackConfiguration {    
    public let lowerLeadingOffset: CGFloat
    public let lowerTrailingOffset: CGFloat
    public let upperLeadingOffset: CGFloat
    public let upperTrailingOffset: CGFloat
    
    public let trackHeight: CGFloat = 8
    public let cornerRadius: CGFloat = 4
    public let backgroundColor: UIColor = UIColor.gray
    public let foregroundColor: UIColor = UIColor.red
    
    public init(lowerLeadingOffset: CGFloat = 0,
                lowerTrailingOffset: CGFloat = 0,
                upperLeadingOffset: CGFloat = 0,
                upperTrailingOffset: CGFloat = 0) {
        self.lowerLeadingOffset = lowerLeadingOffset
        self.lowerTrailingOffset = lowerTrailingOffset
        self.upperLeadingOffset = upperLeadingOffset
        self.upperTrailingOffset = upperTrailingOffset
    }
}

public extension TrackConfiguration {
    init(lowerOffset: CGFloat = 0,
         upperOffset: CGFloat = 0) {
        self.lowerLeadingOffset = lowerOffset / 2
        self.lowerTrailingOffset = lowerOffset / 2 + upperOffset
        self.upperLeadingOffset = lowerOffset + upperOffset / 2
        self.upperTrailingOffset = upperOffset / 2
    }
}

public extension TrackConfiguration {
    init(offsets: CGFloat = 0) { 
        self.lowerLeadingOffset = offsets / 2
        self.lowerTrailingOffset = offsets / 2 + offsets
        self.upperLeadingOffset = offsets + offsets / 2
        self.upperTrailingOffset = offsets / 2
    }
}
