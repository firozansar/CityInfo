
class CityInfo {
    var fcodeName:String?
    var wikipedia:String?
    var geonameId: Int!
    var population:Int?
    var countrycode:String?
    var fclName:String?
    var lat : Double!
    var lng: Double!
    var fcode: String?
    var toponymName:String?
    var name:String!
    var fcl:String?
    
    init?(json:JSON){
        // if any required field is missing we must not create the object.
        if let name = json["name"].string, geonameId = json["geonameId"].int, lat = json["lat"].double,
            lng = json["lng"].double {
            self.name = name
            self.geonameId = geonameId
            self.lat = lat
            self.lng = lng
        }else{
            return nil
        }
        
        self.fcodeName = json["fcodeName"].string
        self.wikipedia = json["wikipedia"].string
        self.population = json["population"].int
        self.countrycode = json["countrycode"].string
        self.fclName = json["fclName"].string
        self.fcode = json["fcode"].string
        self.toponymName = json["toponymName"].string
        self.fcl = json["fcl"].string
    }
}
