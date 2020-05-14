#if os(macOS)
import AppKit
#else
import UIKit
#endif

public extension CGSize {
    /// Rounds width and height based on the given rule
    func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGSize {
        return CGSize(width: width.rounded(rule), height: height.rounded(rule))
    }
}

public extension CGRect {
    init(origin: CGPoint = .zero, width: CGFloat, height: CGFloat) {
        self.init(origin: origin, size: CGSize(width: width, height: height))
    }

    init(widthHeight: CGFloat) {
        self.init()
        self.origin = .zero
        self.size = CGSize(widthHeight: widthHeight)
    }

    var x: CGFloat {
        get {
            return origin.x
        }
        set {
            origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return origin.y
        }
        set {
            origin.y = newValue
        }
    }

//    /// `width` and `height` are defined in Foundation as getters only. We add support for setters too.
//    /// These will not work when imported as a framework: https://bugs.swift.org/browse/SR-4017
//    var width: CGFloat {
//        get {
//            return size.width
//        }
//        set {
//            size.width = newValue
//        }
//    }
//
//    var height: CGFloat {
//        get {
//            return size.height
//        }
//        set {
//            size.height = newValue
//        }
//    }

    // MARK: - Edges

    var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }

    var right: CGFloat {
        get {
            return x + width
        }
        set {
            x = newValue - width
        }
    }
    
    var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }

    var bottom: CGFloat {
        get {
            return y + height
        }
        set {
            y = newValue - height
        }
    }

    // MARK: -

    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin = CGPoint(
                x: newValue.x - (size.width / 2),
                y: newValue.y - (size.height / 2)
            )
        }
    }

    var centerX: CGFloat {
        get {
            return midX
        }
        set {
            center = CGPoint(x: newValue, y: midY)
        }
    }

    var centerY: CGFloat {
        get {
            return midY
        }
        set {
            center = CGPoint(x: midX, y: newValue)
        }
    }

    /**
    Returns a CGRect where `self` is centered in `rect`
    */
    func centered(in rect: CGRect, xOffset: Double = 0, yOffset: Double = 0) -> CGRect {
        return CGRect(
            x: ((rect.width - size.width) / 2) + CGFloat(xOffset),
            y: ((rect.height - size.height) / 2) + CGFloat(yOffset),
            width: size.width,
            height: size.height
        )
    }

    /**
    Returns a CGRect where `self` is centered in `rect`

    - Parameters:
        - xOffsetPercent: The offset in percentage of `rect.width`
    */
    func centered(in rect: CGRect, xOffsetPercent: Double, yOffsetPercent: Double) -> CGRect {
        return centered(
            in: rect,
            xOffset: Double(rect.width) * xOffsetPercent,
            yOffset: Double(rect.height) * yOffsetPercent
        )
    }
}

public extension CGSize {
    static func * (lhs: CGSize, rhs: Double) -> CGSize {
        return CGSize(width: lhs.width * CGFloat(rhs), height: lhs.height * CGFloat(rhs))
    }

    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    init(widthHeight: CGFloat) {
        self.init(width: widthHeight, height: widthHeight)
    }

    var cgRect: CGRect {
        return CGRect(origin: .zero, size: self)
    }

    func aspectFit(to boundingSize: CGSize) -> CGSize {
        let ratio = min(boundingSize.width / width, boundingSize.height / height)
        return self * ratio
    }

    func aspectFit(to widthHeight: CGFloat) -> CGSize {
        return aspectFit(to: CGSize(width: widthHeight, height: widthHeight))
    }
}
