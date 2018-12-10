import Vapor
import FluentPostgreSQL

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    
    init(short: String, long: String) {
        self.short = short
        self.long = long
    }
}

extension Acronym: PostgreSQLModel {
   /* // 1
    typealias Database = MySQLDatabase
    // 2
    typealias ID = Int
    // 3
    public static var idKey: IDKey = \Acronym.id
  */
}

//extension Acronym: SQLiteModel {}

extension Acronym: Migration {}

extension Acronym: Content {}


