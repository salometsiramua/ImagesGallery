//
//  Constants.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit

enum Constants {
    enum Size {
        case cell
        case sectionHeader
        
        var value: CGFloat {
            switch self {
            case .cell:
                return 100
            case .sectionHeader:
                return 40
            }
        }
    }
    
    enum Spacing {
        case margin
        case padding
        
        var value: CGFloat {
            switch self {
            case .margin:
                return 30
            case .padding:
                return 10
            }
        }
    }
}

enum Storyboard {
    case main
    case details
    
    var value: UIStoryboard {
        switch self {
        case .main:
            return UIStoryboard(name: "Main", bundle: nil)
        case .details:
            return UIStoryboard(name: "Details", bundle: nil)
        }
    }
}
