import Foundation

// MARK: - RangeSliderConfiguration

public struct RangeSliderConfiguration {
    public init(range: ClosedRange<CGFloat> = 2 ... 8) {
        self.trackConfiguration = .init(lowerLeadingOffset: lowerThumbSize.width / 2,
                                        lowerTrailingOffset: lowerThumbSize.width / 2 + upperThumbSize.width,
                                        upperLeadingOffset: lowerThumbSize.width + upperThumbSize.width / 2,
                                        upperTrailingOffset: upperThumbSize.width / 2)
        self.range = range
    }
    
    private var _range: ClosedRange<CGFloat> = 2 ... 8
    public var range: ClosedRange<CGFloat> {
        get { CGFloat(_range.clamped(to: bounds).lowerBound) ... CGFloat(_range.clamped(to: bounds).upperBound) }
        set { _range = CGFloat(newValue.lowerBound) ... CGFloat(newValue.upperBound) }
    }
    public let bounds: ClosedRange<CGFloat> = 0 ... 10
    public let step: CGFloat = 1
    public let distance: ClosedRange<CGFloat> = 1 ... .infinity

    public let lowerThumbSize = CGSize(width: 27, height: 27)
    public let upperThumbSize = CGSize(width: 27, height: 27)
    public let lowerThumbInteractiveSize = CGSize(width: 44, height: 44)
    public let upperThumbInteractiveSize = CGSize(width: 44, height: 44)
    
    public let trackConfiguration: TrackConfiguration

    public static let `default`: RangeSliderConfiguration = .init()
}


