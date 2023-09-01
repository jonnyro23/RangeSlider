import Foundation

// MARK: - RangeSliderConfiguration

public struct RangeSliderConfiguration {
    public init(range: ClosedRange<CGFloat>,
                  bounds: ClosedRange<CGFloat>,
                  step: CGFloat,
                  distance: ClosedRange<CGFloat>,
                  lowerThumbSize: CGSize,
                  upperThumbSize: CGSize,
                  trackConfiguration: TrackConfiguration) {
        self._range = range
        self.bounds = bounds
        self.step = step
        self.distance = distance
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
        self.trackConfiguration = trackConfiguration
    }

    public var range: ClosedRange<CGFloat> {
        get { CGFloat(_range.clamped(to: bounds).lowerBound) ... CGFloat(_range.clamped(to: bounds).upperBound) }
        set { _range = newValue }
    }
    private var _range: ClosedRange<CGFloat>

    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let distance: ClosedRange<CGFloat>

    public let lowerThumbSize: CGSize
    public let upperThumbSize: CGSize
    
    public let trackConfiguration: TrackConfiguration

    public static let `default`: RangeSliderConfiguration = .init(range: 2 ... 8,
                                                                  bounds: 0 ... 10,
                                                                  step: 1,
                                                                  distance: 0 ... .infinity,
                                                                  lowerThumbSize: .init(width: 24, height: 24),
                                                                  upperThumbSize: .init(width: 24, height: 24),
                                                                  trackConfiguration: .init(lowerLeadingOffset: 12,
                                                                                            lowerTrailingOffset: 36,
                                                                                            upperLeadingOffset: 36,
                                                                                            upperTrailingOffset: 12,
                                                                                            trackHeight: 6,
                                                                                            cornerRadius: 3,
                                                                                            backgroundColor: .gray,
                                                                                            foregroundColor: .red))
}


