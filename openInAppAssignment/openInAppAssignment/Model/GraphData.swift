import Foundation


//this is the Dummy data
struct PetData: Identifiable {
    let id = UUID() 
    let year: Int
    let population: Double
    
    static let catExample: [PetData] = [
        PetData(year: 1998, population: 10),
        PetData(year: 2000, population: 25),
        PetData(year: 2005, population: 20),
        PetData(year: 2010, population: 55),
        PetData(year: 2015, population: 30),
        PetData(year: 2020, population: 35),
        PetData(year: 2024, population: 30)
    ]
}
