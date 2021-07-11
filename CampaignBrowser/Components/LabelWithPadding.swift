import UIKit


/**
 A custom label that has some padding between its frame and its displayed text. Configurable in Interface Builder.
 */
@IBDesignable
class LabelWithPadding: UILabel {

    /** The padding (in points). Will be added to top edge. */
    @IBInspectable var topTextpadding: CGFloat = 8

    /** The padding (in points). Will be added to bottom edge. */
    @IBInspectable var bottomTextpadding: CGFloat = 8

    /** The padding (in points). Will be added to left edge. */
    @IBInspectable var leftTextpadding: CGFloat = 8

    /** The padding (in points). Will be added to right edge. */
    @IBInspectable var rightTextpadding: CGFloat = 8

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: topTextpadding,
                                                       left: leftTextpadding,
                                                       bottom: bottomTextpadding,
                                                       right: rightTextpadding)))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + leftTextpadding + rightTextpadding,
                      height: originalSize.height + topTextpadding + bottomTextpadding)
    }
}
