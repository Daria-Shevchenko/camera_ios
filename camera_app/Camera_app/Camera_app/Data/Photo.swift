//
//  Photo.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import Foundation
import UIKit

struct Photo: Identifiable {
    let id = UUID().uuidString.lowercased()
    let image: UIImage
}
