//
//  HTMLParserService.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 17.05.2023.
//

import Foundation
import SwiftSoup
import WebKit


class HTMLParserService {

    func fetchFirstImageURL(searchTerm: String) -> String {
        
        var imageUrl = ""
        
        guard let url = URL(string: "https://yandex.ru/images/search?from=tabbar&text=\(searchTerm)") else {
            print("Неверный URL")
            return ""
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ошибка загрузки данных: \(error.localizedDescription)")
                return
            }

            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                print("Нет данных или неверная кодировка")
                return
            }

            do {
                let doc: Document = try SwiftSoup.parse(html)
                let imgElements: Elements = try doc.select("img.serp-item__thumb.justifier__thumb")

                if let firstImage = imgElements.randomElement(),
                   let imgUrl = try? firstImage.attr("src") {
                    print("URL первой картинки: \(imgUrl)")
                    print("https:" + imgUrl)
                    imageUrl = "https:" + imgUrl
                } else {
                    print("Картинка не найдена")
                }
            } catch {
                print("Ошибка при парсинге HTML: \(error)")
            }
        }

        task.resume()
        return imageUrl
    }
}







