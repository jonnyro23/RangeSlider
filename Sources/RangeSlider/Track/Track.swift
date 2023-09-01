import Foundation
import UIKit

// MARK: - Track

class Track: UIView {
    
    var range: ClosedRange<CGFloat> = 0.3 ... 0.6 {
        didSet {
            updateTrackViewFrame()
            updateRangeViewFrame()
        }
    }
    
    var trackBounds: ClosedRange<CGFloat> = 0.0 ... 1.0 {
        didSet {
            updateTrackViewFrame()
            updateRangeViewFrame()
        }
    }

    var configuration: TrackConfiguration = .init()

    let trackView: UIView = .init()
    let rangeView: UIView = .init()

    init(range: ClosedRange<CGFloat>,
                trackBounds: ClosedRange<CGFloat>,
                configuration: TrackConfiguration) {
        self.range = range
        self.configuration = configuration
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override var frame: CGRect {
        didSet {
            updateTrackViewFrame()
            updateRangeViewFrame()
        }
    }

    func setup() {
        addSubview(trackView)
        addSubview(rangeView)

        updateTrackViewFrame()
        configureTrackViewAppearance()
        updateRangeViewFrame()
        configureRangeViewAppearance()
    }

    func configureRangeViewAppearance() {
        rangeView.backgroundColor = configuration.foregroundColor
        rangeView.layer.cornerRadius = configuration.cornerRadius
    }

    func configureTrackViewAppearance() {
        trackView.backgroundColor = configuration.backgroundColor
        trackView.layer.cornerRadius = configuration.cornerRadius
    }

    func updateRangeViewFrame() {
        let leadingOffset = distanceFrom(
            value: range.lowerBound,
            availableDistance: frame.size.width,
            bounds: trackBounds,
            leadingOffset: configuration.lowerLeadingOffset,
            trailingOffset: configuration.lowerTrailingOffset
        )
        let width = rangeDistance(
            overallLength: frame.size.width,
            range: range,
            bounds: trackBounds,
            lowerStartOffset: configuration.lowerLeadingOffset,
            lowerEndOffset: configuration.lowerTrailingOffset,
            upperStartOffset: configuration.upperLeadingOffset,
            upperEndOffset: configuration.upperTrailingOffset
        )
        rangeView.frame = .init(x: leadingOffset,
                                y: center.y - configuration.trackHeight / 2,
                                width: width,
                                height: configuration.trackHeight)
    }

    func updateTrackViewFrame() {
        let leadingOffset = distanceFrom(
            value: trackBounds.lowerBound,
            availableDistance: frame.size.width,
            bounds: trackBounds,
            leadingOffset: 0,
            trailingOffset: 0
        )
        let width = rangeDistance(
            overallLength: frame.size.width,
            range: trackBounds,
            bounds: trackBounds,
            lowerStartOffset: configuration.lowerLeadingOffset,
            lowerEndOffset: configuration.lowerTrailingOffset,
            upperStartOffset: 0,
            upperEndOffset: 0
        )
        trackView.frame = .init(x: leadingOffset,
                                y: center.y - configuration.trackHeight / 2,
                                width: width,
                                height: configuration.trackHeight)
    }
}
