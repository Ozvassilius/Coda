//
//  RSSParser.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import Foundation

class RSSParser: NSObject, XMLParserDelegate {

    var articles: [Article] = []
    var title = ""
    var pubDate = ""
    var link = ""
    var imageUrl = ""

    var element = "" // pour savoir de quel element il s'agit

    var completion : (([Article]) -> Void)?

    func parse(_ urlString: String, completion: (([Article]) -> Void)?) {

        self.completion = completion

        if let url = URL(string: urlString) { // on verifie si l'urlstring est une url valide
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let d = data {
                        let parser = XMLParser(data: d)
                        parser.delegate = self
                        parser.parse()
                    } else {
                        // Arreter
                        self.completion?(self.articles)
                    }
                } else {
                    // Arreter
                     self.completion?(self.articles)
                }
            }.resume()
        } else {
                 self.completion?(self.articles)
            }
    }

   

    // quand on recupere un element (cad une balise)
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName

        // si on tombe sur un item on fait un petit nettoyage
        if element == "item" {
            title = ""
            pubDate = ""
            link = ""
            imageUrl = ""
        }

        // !!! code supprimé ici pour l'url de l'image !!!


    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch element {
        case "title": title += string // pour du texte on ajoute les caracteres par caracteres
        case "link": if link == "" { link = string } // si c'est un lien on verifie qu'il n'y a pas un caractere vide, si c'est pas vide on prend tout le link d'un coup
        case "pubDate": if pubDate == "" { pubDate = string } // meme chose pour la pubDate
        case "description":
            if imageUrl == "" {
            imageUrl = string
                imageUrl = imageUrl.extractURLs().first?.absoluteString ?? ""
                print(imageUrl)
            }
        default:
            break
        }
    }

    // quand on arrive a une balise de fin
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        // on se soucie que de la balise item
        if elementName == "item" {
            let new = Article(title: title, link: link, pubDate:pubDate, imageUrl: imageUrl)
            articles.append(new)
        }

        // une fois qu'on a donc fini de parser l'item on creer une nouvelle instance d'article et on l'ajoute a notre array articles

    }

    func parserDidEndDocument(_ parser: XMLParser) {
        // Envoyer les donnees
         self.completion?(self.articles)
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // Arreter
        print("ParseError: " + parseError.localizedDescription)
         self.completion?(self.articles)
    }
}
