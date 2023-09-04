import Foundation

/// Calculates range distance in points
@inlinable func rangeDistance(overallLength: CGFloat,
                              range: ClosedRange<CGFloat>,
                              bounds: ClosedRange<CGFloat> = 0.0...1.0,
                              lowerStartOffset: CGFloat = 0,
                              lowerEndOffset: CGFloat = 0,
                              upperStartOffset: CGFloat = 0,
                              upperEndOffset: CGFloat = 0) -> CGFloat {
    let offsetLowerValue = distanceFrom(value: range.lowerBound, availableDistance: overallLength, bounds: bounds, leadingOffset: lowerStartOffset, trailingOffset: lowerEndOffset)
    let offsetUpperValue = distanceFrom(value: range.upperBound, availableDistance: overallLength, bounds: bounds, leadingOffset: upperStartOffset, trailingOffset: upperEndOffset)
    return max(0, offsetUpperValue - offsetLowerValue)
}

@inlinable func rangeFrom(updatedLowerBound: CGFloat,
                          upperBound: CGFloat,
                          bounds: ClosedRange<CGFloat>,
                          distance: ClosedRange<CGFloat>,
                          forceAdjacent: Bool) -> ClosedRange<CGFloat> {
    if forceAdjacent {
        let finalLowerBound = min(updatedLowerBound, bounds.upperBound - distance.lowerBound)
        let finalUpperBound = min(min(max(updatedLowerBound + distance.lowerBound, upperBound), updatedLowerBound + distance.upperBound), bounds.upperBound)
        return finalLowerBound ... finalUpperBound
    } else {
        let finalLowerBound = min(updatedLowerBound, upperBound - distance.lowerBound)
        let finalUpperBound = min(upperBound, updatedLowerBound + distance.upperBound)
        return finalLowerBound ... finalUpperBound
    }
}

@inlinable func rangeFrom(lowerBound: CGFloat, updatedUpperBound: CGFloat, bounds: ClosedRange<CGFloat>, distance: ClosedRange<CGFloat>, forceAdjacent: Bool) -> ClosedRange<CGFloat> {
    if forceAdjacent {
        let finalLowerBound = max(max(min(lowerBound, updatedUpperBound - distance.lowerBound), updatedUpperBound - distance.upperBound), bounds.lowerBound)
        let finalUpperBound = max(updatedUpperBound, bounds.lowerBound + distance.lowerBound)
        return finalLowerBound ... finalUpperBound
    } else {
        let finalLowerBound = max(lowerBound, updatedUpperBound - distance.upperBound)
        let finalUpperBound = max(lowerBound + distance.lowerBound, updatedUpperBound)
        return finalLowerBound ... finalUpperBound
    }
}

/// Linear calculations

/// Calculates distance from zero in points
@inlinable func distanceFrom(value: CGFloat,
                             availableDistance: CGFloat,
                             bounds: ClosedRange<CGFloat> = 0.0...1.0,
                             leadingOffset: CGFloat = 0,
                             trailingOffset: CGFloat = 0) -> CGFloat {
    guard availableDistance > leadingOffset + trailingOffset else { return 0 }
    guard bounds.upperBound - bounds.lowerBound != 0 else { return 0 }
    let boundsLenght = bounds.upperBound - bounds.lowerBound
    let relativeValue = (value - bounds.lowerBound) / boundsLenght
    let offset = (leadingOffset - ((leadingOffset + trailingOffset) * relativeValue))
    return offset + (availableDistance * relativeValue)
}

/// Calculates value for relative point in bounds with step.
/// Example: For relative value 0.5 in range 2.0..4.0 produces 3.0
@inlinable func valueFrom(distance: CGFloat,
                          availableDistance: CGFloat,
                          bounds: ClosedRange<CGFloat> = 0.0...1.0,
                          step: CGFloat = 0.001,
                          leadingOffset: CGFloat = 0,
                          trailingOffset: CGFloat = 0) -> CGFloat {
    guard (availableDistance - (leadingOffset + trailingOffset)) != 0 else { return 0 }
    guard step != 0 else { return 0 }
    let relativeValue = (distance - leadingOffset) / (availableDistance - (leadingOffset + trailingOffset))
    let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
    return validatedValue
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
