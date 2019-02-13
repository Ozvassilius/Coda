//
//  Extension Type.swift
//  Codabee
//
//  Created by Macinstosh on 08/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func extractURLs() -> [URL] {
        var urls : [URL] = []
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            detector.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count), using: { (result, _, _) in
                if let match = result, let url = match.url {
                    urls.append(url)
                }
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return urls
    }

    func getDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
        formatter.locale = Locale(identifier: LOCALE)
        return formatter.date(from: self) ?? Date()
    }

    func ilYA() -> String {
        let date = getDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: date, to: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0

        var base = "Il y a "

        if month > 0 {
            return base + String(month) + " mois"
        }

        if day > 0 {
            base = base + String(day) + " jour"
            if day > 1 {
                base += "s"
            }
            return base
        }

        if hour > 0 {
            base = base + String(hour) + " heure"
            if hour > 1 {
                base += "s"
            }
            return base
        }

        if minute > 0 {
            base = base + String(minute) + " minute"
            if minute > 1 {
                base += "s"
            }
            return base
        }


        return "A l'instant"
    }

    func height(_ width: CGFloat , font: UIFont) -> CGFloat {
        
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let boundingBox = NSString(string: self).boundingRect(with: size, options: options, attributes: [.font:font], context: nil)
        return boundingBox.height

    }
}

extension Date {

    func toString() -> String {
        let formatteur = DateFormatter()
        formatteur.dateFormat = DATE_FORMAT
        formatteur.locale = Locale(identifier: LOCALE)

        return formatteur.string(from: self)
    }
}


