#if os(iOS)
import UIKit

public extension UIImage {
    /// Creates an image with the given size
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image
    }
    
    /// Creates an image with the given color of size 1x1
    static func with(color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }

    /// Tints the image with the given color
    func tint(color: UIColor) -> UIImage {
        let maskImage = cgImage
        let bounds = CGRect(origin: .zero, size: size)

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let cgContext = context.cgContext
            cgContext.clip(to: bounds, mask: maskImage!)
            color.setFill()
            cgContext.fill(bounds)
        }
    }
}
#endif
