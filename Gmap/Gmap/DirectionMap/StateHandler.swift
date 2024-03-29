

import Foundation
import CoreLocation
import GoogleMaps
import Combine

class StateHandler:ObservableObject{
    
    @Published var userDropLocation:CLLocationCoordinate2D? //Location user selected in DirectionSearchView
    @Published var userPickupLocation:CLLocationCoordinate2D?
    
    @Published var didSelectCurrentPickLocation:Bool = false
    @Published var didSelectionCurrentDropLocation:Bool = false
    
    @Published var updatedPickupLocation:CLLocationCoordinate2D?
    @Published var updatedDropLocation:CLLocationCoordinate2D?
    
    @Published var updatedState:GMSCameraPosition! //prev rakh rhe hai isme...
    @Published var currentState:GMSCameraPosition! //ye show ho rhi hai user ko......
    
    var direction:DirectionLocationManager = DirectionLocationManager()
    var cancellables:Set<AnyCancellable> = Set<AnyCancellable>()
    
    var makeApiCall:(() async ->Void)?
    init(){
        logic()
    }
    
    deinit{
        cancellables = Set<AnyCancellable>()
    }
    func logic(){
        direction.$location.sink { [self] newLocation in
            if(didSelectionCurrentDropLocation){
                self.updatedDropLocation = newLocation?.coordinate
                if let x = makeApiCall{
                    Task{
                        await x()
                    }
                }
                self.retrievePrevState()
                print(">>>>>>>>>>>")
                //Call API
                
            }else if(didSelectCurrentPickLocation){
                self.updatedPickupLocation = newLocation?.coordinate
                
                if let x = makeApiCall{
                    Task{
                        await x()
                    }
                }
                
                self.retrievePrevState()
                print("<<<<<<<<<<<")
                //Call API
            }
        }
        .store(in: &cancellables)
    }
    
    func makeCamera(){
        self.currentState = GMSCameraPosition.camera(withLatitude: self.userPickupLocation!.latitude, longitude: self.userPickupLocation!.longitude, zoom: 15)
        
        self.updatedState = currentState
    }
    
    func retrievePrevState(){
        self.currentState = updatedState
    }
    
    
}
