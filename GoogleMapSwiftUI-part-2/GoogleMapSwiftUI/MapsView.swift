import SwiftUI
import GoogleMaps
import CoreLocation

class Coordinator: NSObject, CLLocationManagerDelegate {
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    var polyline: GMSPolyline?
    @Binding var totalDistance: CLLocationDistance
    var coordinates: [CLLocationCoordinate2D] = [] // Store coordinates here

    init(totalDistance: Binding<CLLocationDistance>) {
        self._totalDistance = totalDistance
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        if let previousLocation = self.previousLocation {
            let distance = location.distance(from: previousLocation)
            self.totalDistance += distance
        }

        // Store the coordinate
        coordinates.append(location.coordinate)

        // Update polyline
        if let path = polyline?.path {
            let mutablePath = GMSMutablePath(path: path)
            mutablePath.add(location.coordinate)
            polyline?.path = mutablePath
        } else {
            let path = GMSMutablePath()
            path.add(location.coordinate)

            let newPolyline = GMSPolyline(path: path)
            newPolyline.strokeColor = .red
            newPolyline.strokeWidth = 5.0
            newPolyline.map = mapView
            polyline = newPolyline
        }

        let zoom: Float = 18.0 // Default zoom level
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoom)
        mapView?.animate(to: camera)

        self.previousLocation = location

        // Call generatePolylineURL() here
        let polylineURL = generatePolylineURL()
        print(polylineURL)
    }


    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView?.isMyLocationEnabled = true
            mapView?.settings.myLocationButton = true
        }
    }

    // Method to generate the polyline URL
    func generatePolylineURL() -> String {
        var url = "https://maps.googleapis.com/maps/api/staticmap?size=512x512"
        for coordinate in coordinates {
            url += "&markers=\(coordinate.latitude),\(coordinate.longitude)"
        }
       // print("Generated Polyline URL:", url) // Print the constructed URL
        return url
    }
}

struct MapView: UIViewRepresentable {
    @Binding var totalDistance: CLLocationDistance

    func makeCoordinator() -> Coordinator {
        return Coordinator(totalDistance: $totalDistance)
    }

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        context.coordinator.mapView = mapView

        // Request permission
        context.coordinator.locationManager.requestWhenInUseAuthorization()
        context.coordinator.locationManager.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}

