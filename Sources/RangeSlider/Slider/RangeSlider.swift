import UIKit

// MARK: - RangeSlider

public class RangeSlider: UIControl {
    public var configuration: RangeSliderConfiguration {
        didSet {
            updateTrackFrame()
            updateLowerThumbFrame()
            updateUpperThumbFrame()
        }
    }
    
    public var options: RangeSliderOptions {
        didSet {
            updateTrackFrame()
            updateLowerThumbFrame()
            updateUpperThumbFrame()
        }
    }

    private let track: Track
    private let lowerThumb: UIView
    private let upperThumb: UIView

    private var selectedThumb: UIView?
    private var dragOffset: CGFloat?

    override public var frame: CGRect {
        didSet {
            updateTrackFrame()
            updateLowerThumbFrame()
            updateUpperThumbFrame()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updateTrackFrame()
        updateLowerThumbFrame()
        updateUpperThumbFrame()
    }

    public init(
        lowerThumb: UIView = .defaultLowerThumb,
        upperThumb: UIView = .defaultUpperThumb,
        configuration: RangeSliderConfiguration = .default,
        options: RangeSliderOptions = .default
    ) {
        track = .init(range: configuration.range,
                      trackBounds: configuration.bounds,
                      configuration: configuration.trackConfiguration)
        self.lowerThumb = lowerThumb
        self.upperThumb = upperThumb
        self.configuration = configuration
        self.options = options
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        selectedThumb == nil ? true : false
    }

    func setup() {
        clipsToBounds = false
        layer.masksToBounds = false
        addSubview(track)
        addSubview(lowerThumb)
        addSubview(upperThumb)
        updateTrackFrame()
        updateLowerThumbFrame()
        updateUpperThumbFrame()
    }

    func updateTrackFrame() {
        track.frame = .init(x: 0,
                            y: center.y - frame.height / 2,
                            width: frame.width,
                            height: frame.height)
        track.range = configuration.range
        track.trackBounds = configuration.bounds
        track.configuration = configuration.trackConfiguration
    }

    func updateLowerThumbFrame() {
        let leadingOffset = distanceFrom(
            value: configuration.range.lowerBound,
            availableDistance: frame.size.width - configuration.upperThumbSize.width,
            bounds: configuration.bounds,
            leadingOffset: configuration.lowerThumbSize.width / 2,
            trailingOffset: configuration.lowerThumbSize.width / 2
        )
        lowerThumb.frame = .init(x: leadingOffset,
                                 y: frame.midY,
                                 width: configuration.lowerThumbSize.width,
                                 height: configuration.lowerThumbSize.height)
        lowerThumb.center = .init(x: leadingOffset,
                                  y: frame.midY)
    }

    func updateUpperThumbFrame() {
        let leadingOffset = distanceFrom(
            value: configuration.range.upperBound,
            availableDistance: frame.size.width,
            bounds: configuration.bounds,
            leadingOffset: configuration.lowerThumbSize.width + configuration.upperThumbSize.width / 2,
            trailingOffset: configuration.upperThumbSize.width / 2
        )
        upperThumb.frame = .init(x: leadingOffset,
                                 y: frame.midY,
                                 width: configuration.upperThumbSize.width,
                                 height: configuration.upperThumbSize.height)
        upperThumb.center = .init(x: leadingOffset,
                                  y: frame.midY)
    }

    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location: CGPoint = touch.location(in: self)
        if lowerThumb.frame.contains(location) {
            selectedThumb = lowerThumb
            if dragOffset == nil {
                dragOffset = location.x - distanceFrom(
                    value: configuration.range.lowerBound,
                    availableDistance: frame.size.width - configuration.upperThumbSize.width,
                    bounds: configuration.bounds,
                    leadingOffset: configuration.lowerThumbSize.width / 2,
                    trailingOffset: configuration.lowerThumbSize.width / 2
                )
            }
            return true
        } else if upperThumb.frame.contains(location) {
            selectedThumb = upperThumb
            if dragOffset == nil {
                dragOffset = location.x - distanceFrom(
                    value: configuration.range.upperBound,
                    availableDistance: frame.size.width,
                    bounds: configuration.bounds,
                    leadingOffset: configuration.lowerThumbSize.width + configuration.upperThumbSize.width / 2,
                    trailingOffset: configuration.upperThumbSize.width / 2
                )
            }
            return true
        }

        return false
    }

    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard selectedThumb != nil else { return false }

        let location: CGPoint = touch.location(in: self)
        if selectedThumb == lowerThumb {
            if dragOffset == nil {
                dragOffset = location.x - distanceFrom(
                    value: configuration.range.lowerBound,
                    availableDistance: frame.size.width - configuration.upperThumbSize.width,
                    bounds: configuration.bounds,
                    leadingOffset: configuration.lowerThumbSize.width / 2,
                    trailingOffset: configuration.lowerThumbSize.width / 2
                )
            }

            let computedLowerBound = valueFrom(
                distance: location.x - (dragOffset ?? 0),
                availableDistance: frame.size.width - configuration.upperThumbSize.width,
                bounds: configuration.bounds,
                step: configuration.step,
                leadingOffset: configuration.lowerThumbSize.width / 2,
                trailingOffset: configuration.lowerThumbSize.width / 2
            )

            configuration.range = rangeFrom(
                updatedLowerBound: computedLowerBound,
                upperBound: configuration.range.upperBound,
                bounds: configuration.bounds,
                distance: configuration.distance,
                forceAdjacent: options.contains(.forceAdjacentValue)
            )
        } else if selectedThumb == upperThumb {
            if dragOffset == nil {
                dragOffset = location.x - distanceFrom(
                    value: configuration.range.upperBound,
                    availableDistance: frame.size.width,
                    bounds: configuration.bounds,
                    leadingOffset: configuration.lowerThumbSize.width + configuration.upperThumbSize.width / 2,
                    trailingOffset: configuration.upperThumbSize.width / 2
                )
            }

            let computedUpperBound = valueFrom(
                distance: location.x - (dragOffset ?? 0),
                availableDistance: frame.size.width,
                bounds: configuration.bounds,
                step: configuration.step,
                leadingOffset: configuration.lowerThumbSize.width + configuration.upperThumbSize.width / 2,
                trailingOffset: configuration.upperThumbSize.width / 2
            )

            configuration.range = rangeFrom(
                lowerBound: configuration.range.lowerBound,
                updatedUpperBound: computedUpperBound,
                bounds: configuration.bounds,
                distance: configuration.distance,
                forceAdjacent: options.contains(.forceAdjacentValue)
            )
        }

        return true
    }

    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        selectedThumb = nil
        dragOffset = nil
    }
}
