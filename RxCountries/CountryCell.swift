//
//  CountryCell.swift
//  RxCountries
//
//  Created by ahmedpro on 5/29/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet private weak var countryLabel: UILabel!
    var country: Country? {
        didSet {
            countryLabel.text = "name = \(country!.name), code = \(country!.code)"
        }
    }
}
