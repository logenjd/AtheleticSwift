/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Json4Swift_Base : Codable {
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

	init(from decoder: Decoder) throws {
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