import Foundation
import UIKit
//    public init(range: ClosedRange<CGFloat> = 2 ... 8,
//                trackConfiguration: TrackConfiguration) {
//        self.trackConfiguration = .init(lowerLeadingOffset: lowerThumbSize.width / 2,
//                                        lowerTrailingOffset: lowerThumbSize.width / 2 + upperThumbSize.width,
//                                        upperLeadingOffset: lowerThumbSize.width + upperThumbSize.width / 2,
//                                        upperTrailingOffset: upperThumbSize.width / 2)
//        self.range = range
//    }
// MARK: - Track

class Track: UIView {
    var range: ClosedRange<CGFloat> {
        didSet {
            updateTrackViewFrame()
            updateRangeViewFrame()
        }
    }

    var trackBounds: ClosedRange<CGFloat> {
        didSet {
            updateTrackViewFrame()
            updateRangeViewFrame()
        }
    }

    var configuration: TrackConfiguration

    let trackView: UIView = .init()
    let rangeView: UIView = .init()

    init(range: ClosedRange<CGFloat>,
         trackBounds: ClosedRange<CGFloat>,
         configuration: TrackConfiguration)
    {
        self.range = range
        self.trackBounds = trackBounds
        self.configuration = configuration
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        setup()
    }

    override init(frame: CGRect) {
        self.range = 1 ... 9
        self.trackBounds = 0 ... 10
        self.configuration = .init(trackHeight: 0,
                                   cornerRadius: 0,
                                   backgroundColor: .black,
                                   foregroundColor: .black,
                                   lowerThumbSize: .zero,
                                   upperThumbSize: .zero)
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        self.range = 1 ... 9
        self.trackBounds = 0 ... 10
        self.configuration = .init(trackHeight: 0,
                                   cornerRadius: 0,
                                   backgroundColor: .black,
                                   foregroundColor: .black,
                                   lowerThumbSize: .zero,
                                   upperThumbSize: .zero)
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
            leadingOffset: offsets.lowerLeadingOffset,
            trailingOffset: offsets.lowerTrailingOffset
        )
        let width = rangeDistance(
            overallLength: frame.size.width,
            range: range,
            bounds: trackBounds,
            lowerStartOffset: offsets.lowerLeadingOffset,
            lowerEndOffset: offsets.lowerTrailingOffset,
            upperStartOffset: offsets.upperLeadingOffset,
            upperEndOffset: offsets.upperTrailingOffset
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
            lowerStartOffset: 0,
            lowerEndOffset: 0,
            upperStartOffset: 0,
            upperEndOffset: 0
        )
        trackView.frame = .init(x: leadingOffset,
                                y: center.y - configuration.trackHeight / 2,
                                width: width,
                                height: configuration.trackHeight)
    }
    
    private var offsets: TrackOffsets.OffsetValues {
        switch configuration.offsets {
        case .default:
            return .init(lowerLeadingOffset: configuration.lowerThumbSize.width / 2,
                         lowerTrailingOffset: configuration.lowerThumbSize.width / 2 + configuration.upperThumbSize.width,
                         upperLeadingOffset: configuration.lowerThumbSize.width + configuration.upperThumbSize.width / 2,
                         upperTrailingOffset: configuration.upperThumbSize.width / 2)
        case let .custom(values):
            return values
        }
    }
}
