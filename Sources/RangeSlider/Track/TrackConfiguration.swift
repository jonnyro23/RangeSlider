import Foundation
import UIKit

// MARK: - TrackOffsets

public enum TrackOffsets {
    case `default`
    case custom(OffsetValues)

    public struct OffsetValues {
        public let lowerLeadingOffset: CGFloat
        public let lowerTrailingOffset: CGFloat
        public let upperLeadingOffset: CGFloat
        public let upperTrailingOffset: CGFloat
    }
}

// MARK: - TrackConfiguration

struct TrackConfiguration {
    
    let offsets: TrackOffsets
    let trackHeight: CGFloat
    let cornerRadius: CGFloat
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let lowerThumbSize: CGSize
    let upperThumbSize: CGSize

    internal init(offsets: TrackOffsets = .default,
                  trackHeight: CGFloat,
                  cornerRadius: CGFloat,
                  backgroundColor: UIColor,
                  foregroundColor: UIColor,
                  lowerThumbSize: CGSize,
                  upperThumbSize: CGSize) {
        self.offsets = offsets
        self.trackHeight = trackHeight
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
    }
}
