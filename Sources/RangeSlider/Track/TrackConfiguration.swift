import Foundation
import UIKit

// MARK: - TrackConfiguration

public struct TrackConfiguration {
    public let lowerLeadingOffset: CGFloat
    public let lowerTrailingOffset: CGFloat
    public let upperLeadingOffset: CGFloat
    public let upperTrailingOffset: CGFloat

    public let trackHeight: CGFloat
    public let cornerRadius: CGFloat
    public let backgroundColor: UIColor
    public let foregroundColor: UIColor

    public init(lowerLeadingOffset: CGFloat,
                lowerTrailingOffset: CGFloat,
                upperLeadingOffset: CGFloat,
                upperTrailingOffset: CGFloat,
                trackHeight: CGFloat,
                cornerRadius: CGFloat,
                backgroundColor: UIColor,
                foregroundColor: UIColor) {
        self.lowerLeadingOffset = lowerLeadingOffset
        self.lowerTrailingOffset = lowerTrailingOffset
        self.upperLeadingOffset = upperLeadingOffset
        self.upperTrailingOffset = upperTrailingOffset
        self.trackHeight = trackHeight
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
}
