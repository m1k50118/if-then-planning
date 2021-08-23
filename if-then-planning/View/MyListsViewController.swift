//
//  MyListsViewController.swift
//  MyListsViewController
//
//  Created by 佐藤真 on 2021/08/19.
//

import SnapKit
import UIKit

class MyListsViewController: UIViewController {
    private var collectionView: UICollectionView?
    private let spacing: CGFloat = 16.0
    let sectionName = ["", "マイリスト"]
    let data = ["今日", "日時設定あり", "すべて", "フラグ付き"]
    let myLists = ["リマインダー"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .edit,
                                                  target: self,
                                                  action: nil)

        navigationItem.searchController = UISearchController(searchResultsController: ViewController())

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.sectionInset = .init(top: 0,
                                    left: spacing,
                                    bottom: 0,
                                    right: spacing)

        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.backgroundColor = .secondarySystemBackground

        collectionView.register(SpecialPlanListViewCell.self,
                                forCellWithReuseIdentifier: SpecialPlanListViewCell.identifier)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

extension MyListsViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data.count
        default:
            return myLists.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialPlanListViewCell.identifier,
                                                      for: indexPath) as? SpecialPlanListViewCell
        guard let specialPlanListViewCell = cell else {
            return .init()
        }
        specialPlanListViewCell.contentView.layer.cornerRadius = 12
        specialPlanListViewCell.categoryLabel.text = data[indexPath.item]
        specialPlanListViewCell.planCount.text = "0"
        return specialPlanListViewCell
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        sectionName.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: SectionHeaderView.identifier,
                                                                         for: indexPath) as? SectionHeaderView
        guard let headerView = headerView else {
            return .init()
        }
        headerView.sectionLabel.adjustsFontSizeToFitWidth = true
        headerView.sectionLabel.minimumScaleFactor = 17
        return headerView
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = section == 0 ? CGSize.zero : CGSize(width: view.frame.width, height: 48)
        return size
    }
}

extension MyListsViewController: UICollectionViewDelegate {}

extension MyListsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidthSize = (view.frame.width - (spacing * 3)) / 2
        let cellHeightSize = ((view.frame.height) - (spacing * 8)) / 9

        let cellSize = indexPath.section == 0 ? CGSize(width: cellWidthSize, height: cellHeightSize) : CGSize(width: view.frame.width - (spacing * 2), height: cellHeightSize * 0.75)

        return cellSize
    }
}

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeader"

    var sectionLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.myLists()
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionLabel)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
