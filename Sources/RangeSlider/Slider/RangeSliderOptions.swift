import Foundation

// MARK: - RangeSliderOptions

public struct RangeSliderOptions: OptionSet {
    public let rawValue: Int

    public static let forceAdjacentValue = RangeSliderOptions(rawValue: 1 << 0)
    public static let `default`: RangeSliderOptions = .forceAdjacentValue

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
