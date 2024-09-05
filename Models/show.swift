import Foundation


struct Show: Codable {
    var score: Double?
    var show: TvShow?
}

struct TvShow: Codable {
    var id: Int?
    var name: String?
}
