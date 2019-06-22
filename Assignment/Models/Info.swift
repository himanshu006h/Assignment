struct ContactInfo: Decodable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_pic: String?
    let favorite: Bool?
    let url: String?

    enum ContactKey: String, CodingKey {
        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case profile_pic = "profile_pic"
        case favorite = "favorite"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContactKey.self)
         id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
         first_name = try container.decodeIfPresent(String.self, forKey: .first_name) ?? ""
         last_name = try container.decodeIfPresent(String.self, forKey: .last_name) ?? ""
         profile_pic = try container.decodeIfPresent(String.self, forKey: .profile_pic) ?? ""
         favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite) ?? false
         url =  try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
    }
}
