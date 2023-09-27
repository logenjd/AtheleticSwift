import Foundation
class ModelAthlete : Codable {
	let athlete_id : String?
	let name : String?
	let surname : String?
	let dateOfBirth : String?
	let bio : String?
	let weight : Int?
	let height : Int?
	let photo_id : Int?

	enum CodingKeys: String, CodingKey {

		case athlete_id = "athlete_id"
		case name = "name"
		case surname = "surname"
		case dateOfBirth = "dateOfBirth"
		case bio = "bio"
		case weight = "weight"
		case height = "height"
		case photo_id = "photo_id"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		athlete_id = try values.decodeIfPresent(String.self, forKey: .athlete_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		surname = try values.decodeIfPresent(String.self, forKey: .surname)
		dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
		bio = try values.decodeIfPresent(String.self, forKey: .bio)
		weight = try values.decodeIfPresent(Int.self, forKey: .weight)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		photo_id = try values.decodeIfPresent(Int.self, forKey: .photo_id)
	}

}

class ModelGame : Codable {
    let game_id : Int?
    let city : String?
    let year : Int?
    var yearDate : Date
    var athletesList:[ModelAthlete]?
    enum CodingKeys: String, CodingKey {

        case game_id = "game_id"
        case city = "city"
        case year = "year"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        game_id = try values.decodeIfPresent(Int.self, forKey: .game_id)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        if let yr = year, let yrStr = "\(yr)" as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            yearDate = dateFormatter.date(from: yrStr) ?? Date()
        }else{
            yearDate =  Date()
        }
        
    }

}

class ModelMedalDetails : Codable {
    let city : String?
    let year : Int?
    let gold : Int?
    let silver : Int?
    let bronze : Int?

    enum CodingKeys: String, CodingKey {

        case city = "city"
        case year = "year"
        case gold = "gold"
        case silver = "silver"
        case bronze = "bronze"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        gold = try values.decodeIfPresent(Int.self, forKey: .gold)
        silver = try values.decodeIfPresent(Int.self, forKey: .silver)
        bronze = try values.decodeIfPresent(Int.self, forKey: .bronze)
    }

}
