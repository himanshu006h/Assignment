//
//  Contactdetails.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 23/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

struct Contactdetails: Decodable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let email: String?
    let phone_number: String?
    let profile_pic: String?
    let favorite: Bool?
    let created_at: String?
    let updated_at: String?
    
    enum ContactKey: String, CodingKey {
        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case phone_number = "phone_number"
        case profile_pic = "profile_pic"
        case favorite = "favorite"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContactKey.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        first_name = try container.decodeIfPresent(String.self, forKey: .first_name) ?? ""
        last_name = try container.decodeIfPresent(String.self, forKey: .last_name) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number) ?? ""
        profile_pic = try container.decodeIfPresent(String.self, forKey: .profile_pic) ?? ""
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite) ?? false
        created_at =  try container.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        updated_at =  try container.decodeIfPresent(String.self, forKey: .updated_at) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
    }
}
