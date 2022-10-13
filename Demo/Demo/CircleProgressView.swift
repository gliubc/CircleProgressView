import UIKit

@IBDesignable
class CircleProgressView: UIView {
    
    @IBInspectable var circleProgressCenter: CGPoint = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressRadius: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressLineWidth: CGFloat = 7.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressRatio: CGFloat = 0.25 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressBgColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressFgColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressTextColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleProgressTextSize: CGFloat = 12 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if circleProgressRadius == 0 && circleProgressCenter == .zero {
            if (rect.width - circleProgressLineWidth) / (rect.height - circleProgressLineWidth) > 2 {
                circleProgressRadius = rect.height - circleProgressLineWidth
            } else {
                circleProgressRadius = (rect.width - circleProgressLineWidth) / 2
            }
            
            circleProgressCenter = CGPoint(x: rect.midX, y: rect.minY + circleProgressLineWidth / 2 + circleProgressRadius)
        }
        
        drawCircle()
        drawTriangle()
        drawText()
        
        func drawCircle() {
            let circleBgPath = UIBezierPath(arcCenter: circleProgressCenter, radius: circleProgressRadius, startAngle: CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
            circleProgressBgColor.setStroke()
            circleBgPath.lineWidth = circleProgressLineWidth
            circleBgPath.lineCapStyle = .round
            circleBgPath.stroke()
            
            let circleFgPath = UIBezierPath(arcCenter: circleProgressCenter, radius: circleProgressRadius, startAngle: CGFloat.pi, endAngle: (1 + circleProgressRatio) * CGFloat.pi, clockwise: true)
            circleProgressFgColor.setStroke()
            circleFgPath.lineWidth = circleProgressLineWidth
            circleFgPath.lineCapStyle = .round
            circleFgPath.stroke()
        }
        
        func drawTriangle() {
            let path = UIBezierPath()
            let point1 = circleProgressCenter + polar2Cartesian(r: circleProgressRadius + circleProgressLineWidth / 2 + 3, t: (1 + circleProgressRatio) * CGFloat.pi)
            let point2 = circleProgressCenter + polar2Cartesian(r: circleProgressRadius + circleProgressLineWidth / 2 + 3 + 6, t: (1 + circleProgressRatio - 0.017) * CGFloat.pi)
            let point3 = circleProgressCenter + polar2Cartesian(r: circleProgressRadius + circleProgressLineWidth / 2 + 3 + 6, t: (1 + circleProgressRatio + 0.017) * CGFloat.pi)
            path.move(to: point1)
            path.addLine(to: point2)
            path.addLine(to: point3)
            path.close()
            circleProgressFgColor.setFill()
            path.fill()
        }
        
        func drawText() {
            let attributedString = NSAttributedString(string: "\(Int(circleProgressRatio * 100))%", attributes: [.foregroundColor: circleProgressTextColor, .font: UIFont.boldSystemFont(ofSize: circleProgressTextSize)])
            
            let boundingRect = attributedString.boundingRect(with: self.bounds.size, options: .usesLineFragmentOrigin, context: nil)
            
            let w = boundingRect.size.width
            let h = boundingRect.size.height
            
            let t = (1 + circleProgressRatio) * CGFloat.pi
            let r = circleProgressRadius + circleProgressLineWidth / 2 + 3 + 6 + 6 + abs(w / 2 * cos(t * 1.0)) + abs(h / 2 * sin(t * 1.0))
            
            let centerPoint = circleProgressCenter + polar2Cartesian(r: r, t: t)
            
            let textPoint = CGPoint(x: centerPoint.x - boundingRect.midX, y: centerPoint.y - boundingRect.midY)
            
            attributedString.draw(at: textPoint)
        }
    }
    
    private func polar2Cartesian(r: Double, t: Double) -> CGPoint {
        return CGPoint(x: r * cos(t), y: r * sin(t))
    }
}

fileprivate extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}

