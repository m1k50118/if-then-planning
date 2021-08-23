//
//  SpecialPlanListViewCell.swift
//  SpecialPlanListViewCell
//
//  Created by 佐藤真 on 2021/08/21.
//

import SnapKit
import UIKit

class SpecialPlanListViewCell: UICollectionViewCell {
    static let identifier = "SpecialPlanListViewCell"

    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "calendar"))
        return imageView
    }()

    let planCount: UILabel = {
        let label = UILabel()
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        addSubview(iconImage)
        addSubview(planCount)
        addSubview(categoryLabel)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        setupIconImageConstraints()
        setupCategoryLabel()
        setupPlanCount()
    }

    private func setupIconImageConstraints() {
        iconImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview().dividedBy(2)
        }
    }

    private func setupCategoryLabel() {
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImage)
            make.centerY.equalToSuperview().multipliedBy(1.5)
        }
    }

    private func setupPlanCount() {
        planCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview().dividedBy(2)
        }
    }
}
