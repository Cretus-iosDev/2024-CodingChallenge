

import Foundation
import GoogleMaps

class DirectionManager{
    func drawPath(from polyStr: String)->GMSPolyline{
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 10
        polyline.strokeColor = .red
        return polyline
//        polyline.map = mapView // Google MapView
    }}
