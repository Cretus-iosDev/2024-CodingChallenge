import Foundation

struct Json4Swift_Base : Codable {
    let status : Bool?
    let statusCode : Int?
    let message : String?
    let support_whatsapp_number : String?
    let extra_income : Double?
    let total_links : Int?
    let total_clicks : Int?
    let today_clicks : Int?
    let top_source : String?
    let top_location : String?
    let startTime : String?
    let links_created_today : Int?
    let applied_campaign : Int?
    let data : Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case statusCode = "statusCode"
        case message = "message"
        case support_whatsapp_number = "support_whatsapp_number"
        case extra_income = "extra_income"
        case total_links = "total_links"
        case total_clicks = "total_clicks"
        case today_clicks = "today_clicks"
        case top_source = "top_source"
        case top_location = "top_location"
        case startTime = "startTime"
        case links_created_today = "links_created_today"
        case applied_campaign = "applied_campaign"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        support_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .support_whatsapp_number)
        extra_income = try values.decodeIfPresent(Double.self, forKey: .extra_income)
        total_links = try values.decodeIfPresent(Int.self, forKey: .total_links)
        total_clicks = try values.decodeIfPresent(Int.self, forKey: .total_clicks)
        today_clicks = try values.decodeIfPresent(Int.self, forKey: .today_clicks)
        top_source = try values.decodeIfPresent(String.self, forKey: .top_source)
        top_location = try values.decodeIfPresent(String.self, forKey: .top_location)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        links_created_today = try values.decodeIfPresent(Int.self, forKey: .links_created_today)
        applied_campaign = try values.decodeIfPresent(Int.self, forKey: .applied_campaign)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
    }

}

struct Data : Codable {
    let recent_links : [Recent_links]?
    let top_links : [Top_links]?
    let favourite_links : [String]?

    enum CodingKeys: String, CodingKey {
        case recent_links = "recent_links"
        case top_links = "top_links"
        case favourite_links = "favourite_links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recent_links = try values.decodeIfPresent([Recent_links].self, forKey: .recent_links)
        top_links = try values.decodeIfPresent([Top_links].self, forKey: .top_links)
        favourite_links = try values.decodeIfPresent([String].self, forKey: .favourite_links)
    }
}

struct Recent_links: Codable, Hashable {
    let url_id : Int?
    let web_link : String?
    let smart_link : String?
    let title : String?
    let total_clicks : Int?
    let original_image : String?
    let thumbnail : String?
    let times_ago : String?
    let created_at : String?
    let domain_id : String?
    let url_prefix : String?
    let url_suffix : String?
    let app : String?
    let is_favourite : Bool?

    enum CodingKeys: String, CodingKey {
        case url_id = "url_id"
        case web_link = "web_link"
        case smart_link = "smart_link"
        case title = "title"
        case total_clicks = "total_clicks"
        case original_image = "original_image"
        case thumbnail = "thumbnail"
        case times_ago = "times_ago"
        case created_at = "created_at"
        case domain_id = "domain_id"
        case url_prefix = "url_prefix"
        case url_suffix = "url_suffix"
        case app = "app"
        case is_favourite = "is_favourite"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url_id = try values.decodeIfPresent(Int.self, forKey: .url_id)
        web_link = try values.decodeIfPresent(String.self, forKey: .web_link)
        smart_link = try values.decodeIfPresent(String.self, forKey: .smart_link)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        total_clicks = try values.decodeIfPresent(Int.self, forKey: .total_clicks)
        original_image = try values.decodeIfPresent(String.self, forKey: .original_image)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        times_ago = try values.decodeIfPresent(String.self, forKey: .times_ago)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        domain_id = try values.decodeIfPresent(String.self, forKey: .domain_id)
        url_prefix = try values.decodeIfPresent(String.self, forKey: .url_prefix)
        url_suffix = try values.decodeIfPresent(String.self, forKey: .url_suffix)
        app = try values.decodeIfPresent(String.self, forKey: .app)
        is_favourite = try values.decodeIfPresent(Bool.self, forKey: .is_favourite)
    }
    // Hashable conformance
        func hash(into hasher: inout Hasher) {
            hasher.combine(url_id)
            hasher.combine(web_link)
            
        }
}

struct Top_links: Codable, Hashable {
    let url_id : Int?
    let web_link : String?
    let smart_link : String?
    let title : String?
    let total_clicks : Int?
    let original_image : String?
    let thumbnail : String?
    let times_ago : String?
    let created_at : String?
    let domain_id : String?
    let url_prefix : String?
    let url_suffix : String?
    let app : String?
    let is_favourite : Bool?

    enum CodingKeys: String, CodingKey {
        case url_id = "url_id"
        case web_link = "web_link"
        case smart_link = "smart_link"
        case title = "title"
        case total_clicks = "total_clicks"
        case original_image = "original_image"
        case thumbnail = "thumbnail"
        case times_ago = "times_ago"
        case created_at = "created_at"
        case domain_id = "domain_id"
        case url_prefix = "url_prefix"
        case url_suffix = "url_suffix"
        case app = "app"
        case is_favourite = "is_favourite"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url_id = try values.decodeIfPresent(Int.self, forKey: .url_id)
        web_link = try values.decodeIfPresent(String.self, forKey: .web_link)
        smart_link = try values.decodeIfPresent(String.self, forKey: .smart_link)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        total_clicks = try values.decodeIfPresent(Int.self, forKey: .total_clicks)
        original_image = try values.decodeIfPresent(String.self, forKey: .original_image)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        times_ago = try values.decodeIfPresent(String.self, forKey: .times_ago)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        domain_id = try values.decodeIfPresent(String.self, forKey: .domain_id)
        url_prefix = try values.decodeIfPresent(String.self, forKey: .url_prefix)
        url_suffix = try values.decodeIfPresent(String.self, forKey: .url_suffix)
        app = try values.decodeIfPresent(String.self, forKey: .app)
        is_favourite = try values.decodeIfPresent(Bool.self, forKey: .is_favourite)
    }
    func hash(into hasher: inout Hasher) {
           hasher.combine(url_id)
           hasher.combine(web_link)
           
       }
}

