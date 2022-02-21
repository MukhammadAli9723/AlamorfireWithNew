//
//  NetworkManager.swift
//  AlamofireMasterClass
//
//  Created by Muhammadali Yulbarsbekov on 21/02/22.
//

import UIKit


struct NewsResponseModel: Decodable{
    let category: String
    let data: [NewsModel]
    let success: Bool
}

struct NewsModel: Decodable {
    let author: String?
    let content: String?
    let date: String?
    let imageUrl: String?
    let readMoreUrl: String?
    let time: String?
    let title: String?
    let url: String?
}

