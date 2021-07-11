import UIKit
import RxSwift


/**
 The cell which displays a campaign.
 */
class CampaignCell: UICollectionViewCell {
    private let imgageRatio:CGFloat = 4.0/3.0

    private let nameFont = UIFont(name: "Helvetica Neue Bold", size: 18)!
    private let descriptionFont = UIFont(name: "Hoefler Text", size: 14)!

    private let disposeBag = DisposeBag()

    /** Used to display the campaign's title. */
    @IBOutlet private(set) weak var nameLabel: LabelWithPadding!

    /** Used to display the campaign's description. */
    @IBOutlet private(set) weak var descriptionLabel: LabelWithPadding!

    /** The image view which is used to display the campaign's mood image. */
    @IBOutlet private(set) weak var imageView: UIImageView!

    /** The mood image which is displayed as the background. */
    var moodImage: Observable<UIImage>? {
        didSet {
            moodImage?
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] image in
                    self?.imageView.image = image
                    })
                .disposed(by: disposeBag)
        }
    }

    /** The campaign's name. */
    var name: String? {
        didSet {
            nameLabel?.text = name
        }
    }

    var descriptionText: String? {
        didSet {
            descriptionLabel?.text = descriptionText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        assert(nameLabel != nil)
        assert(descriptionLabel != nil)
        assert(imageView != nil)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let cellHeight = self.calculateCellHeight()
        let targetSize = CGSize(width: UIScreen.main.bounds.size.width,
                                height: cellHeight)
        layoutAttributes.frame.size = contentView
            .systemLayoutSizeFitting(targetSize,
                                     withHorizontalFittingPriority: .required,
                                     verticalFittingPriority: .defaultHigh)
        return layoutAttributes
    }

    // Cell Content size calculating
    private func calculateCellHeight() -> CGFloat {
        let cellWidth = UIScreen.main.bounds.size.width
        let imageHeight = cellWidth / self.imgageRatio
        let nameLabelWidth = cellWidth
            - self.nameLabel.leftTextpadding
            - self.nameLabel.rightTextpadding

        let descriptionLabelWidth = cellWidth
            - self.descriptionLabel.leftTextpadding
            - self.descriptionLabel.rightTextpadding

        let nameHeight: CGFloat = self.name?.height(
            withConstrainedWidth: nameLabelWidth,
            font: self.nameFont
        ) ?? 0.0

        let descriptionHeight: CGFloat = self.descriptionText?.height(
            withConstrainedWidth: descriptionLabelWidth,
            font: self.descriptionFont
        ) ?? 0.0

        let totalHeight = imageHeight
            + nameHeight
            + descriptionHeight

        return totalHeight
    }
}
