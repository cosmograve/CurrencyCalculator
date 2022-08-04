//
//  SelectPairViewController.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 03.08.2022.
//

import UIKit

protocol ChangePairDelegate {
    func changePair(index: Int)
}

class SelectPairViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView?
    var changePairDelegate: ChangePairDelegate?
    let cell = "PairCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Select Pair"
        initCollectionView()
    }
    
    func initCollectionView() {
        collection?.backgroundColor = .clear
        collection?.delegate = self
        collection?.dataSource = self
        collection?.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
    }


   
}

extension SelectPairViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CurrencyManager.shared.pairs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PairCollectionViewCell {
            
            cell.pairLabel?.text = CurrencyManager.shared.pairs[indexPath.item]
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changePairDelegate?.changePair(index: indexPath.item)
        self.navigationController?.popViewController(animated: true)
    }
}
