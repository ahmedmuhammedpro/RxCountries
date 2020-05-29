//
//  ViewController.swift
//  RxCountries
//
//  Created by ahmedpro on 5/29/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        Observable<[Country]>.create { (observer) -> Disposable in
            let countries = self.readPlistFile()
            observer.onNext(countries)
            return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        .observeOn(MainScheduler.instance)
        .bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: CountryCell.self)) {
            (index, element, cell) in
            cell.country = element
        }
        .disposed(by: disposeBag)
    }

    func readPlistFile() -> [Country] {
        let plistUrl = Bundle.main.url(forResource: "Countries", withExtension: "plist")!
        if let data = try? Data(contentsOf: plistUrl) {
            let decoder = PropertyListDecoder()
            do {
                let countries = try decoder.decode([Country].self, from: data)
                return countries
            } catch {
                print(error)
            }
        }
        
        return [Country]()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 100
        return CGSize(width: width, height: height)
    }
}
