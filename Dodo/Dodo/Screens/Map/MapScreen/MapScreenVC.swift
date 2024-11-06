//
//  MapView.swift
//  Dodo
//  Created by Tia M on 10/14/24.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

final class MapScreenVC: UIViewController {
    var address: Address?
    
    var bottomConstraint: NSLayoutConstraint?
    var originalConstant: CGFloat = 0
    var keyboardFrame: CGRect = .zero
    
    var locationService: LocationService
    var geocodeService: GeocodeService
    
    var addressRepository: IAddressRepository
    
    let addressPanelView = AddressPanelView()
    
    var onAddressSaved: (() -> Void)?
    
    var pinImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "pin")
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        return imageView
    }()
    
    lazy var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.delegate = self
        
        return mapView
    }()
    
    init(_ addressRepository: IAddressRepository, _ locationService: LocationService, _ geocodeService: GeocodeService) {
        self.addressRepository = addressRepository
        self.locationService = locationService
        self.geocodeService = geocodeService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        setupKeyboardNotifications()
        
        showCurrentLocationOnMap()
        
        observe()
        setupCloseButton()
        saveAddress()
        deleteAddress()
        setMapScreenMode()
    }
    
    private func setupCloseButton() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeScreen))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc private func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    func saveAddress() {
        addressPanelView.onAddressAdded = { [weak self] addressText in
            guard let self else { return }
            
            guard let placemark = self.geocodeService.currentPlacemark else { return }
            
            let address = Address(
                country: placemark.country ?? "Unknown Country",
                administrativeArea: placemark.administrativeArea ?? "Unknown Area",
                name: addressText,
                subLocality: placemark.subLocality ?? "Unknown SubLocality",
                thoroughfare: placemark.thoroughfare ?? "Unknown Street",
                subThoroughfare: placemark.subThoroughfare ?? "Unknown House",
                floor: self.addressPanelView.placeDescriptionView.floorTextField.text,
                apartment: self.addressPanelView.placeDescriptionView.apartmentTextField.text
            )
            self.addressRepository.add(address)
            self.onAddressSaved?()
            self.closeScreen()
        }
    }
    
    func deleteAddress() {
        addressPanelView.onAddressDeleted = { [weak self] address in
            guard let self else { return }
            guard let address = self.address else { return }
            
            self.addressRepository.delete(address)
            self.onAddressSaved?()
            self.closeScreen()
        }
    }
    
    func setMapScreenMode() {
        if let address {
            addressPanelView.update(address.name)
            addressPanelView.placeDescriptionView.floorTextField.text = address.floor
            addressPanelView.placeDescriptionView.apartmentTextField.text = address.apartment
            addressPanelView.setEditingMode(true)
            showAddressOnMap(address.name) // ???
        } else {
            addressPanelView.setEditingMode(false)
        }
    }
}

//MARK: - Observe Logic
extension MapScreenVC {
    func observe() {
        
        addressPanelView.onAddressChanged = { [weak self] addressText in
            guard let self else { return }
            self.showAddressOnMap(addressText)
        }
    }
}

//MARK: - Keyboard
extension MapScreenVC {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressPanelView.addressView.addressTextField.endEditing(true)
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UITextField.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UITextField.keyboardDidHideNotification, object: nil)
        //self.originalConstant = bottomConstraint?.constant ?? 0
        
        self.bottomConstraint = addressPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
           print("keyboardWillShow")
        
        self.keyboardFrame = (notification.userInfo?[UITextField.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        print(self.keyboardFrame)
        
        self.bottomConstraint?.constant = -self.keyboardFrame.height
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        
//           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//               self.bottomConstraint?.constant += keyboardSize.height + 5
//               self.view.layoutIfNeeded()
//           }
       }

       @objc func keyboardWillHide(notification: Notification) {
           print("keyboardWillHide")
//           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//               self.bottomConstraint?.constant = self.originalConstant
//               self.view.layoutIfNeeded()
//           }
           self.keyboardFrame = .zero
           
           self.bottomConstraint?.constant = 0
           
           self.view.setNeedsLayout()
           self.view.layoutIfNeeded()
       }
}

//MARK: - Business Logic
extension MapScreenVC {
    
    func fetchAddressFromLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        self.geocodeService.fetchAddressFromLocation(location) { addressText in
            completion(addressText)
        }
    }
    
    func showAddressOnMap(_ addressText: String) {
        
        geocodeService.fetchLocationFromAddress(addressText) { [weak self] location in
            guard let self else { return }
            self.showLocationOnMap(location)
        }
    }
    
    func showCurrentLocationOnMap() {
        
        locationService.fetchCurrentLocation { [weak self] location in
            
            guard let self else { return }
            
            showLocationOnMap(location)
            
            fetchAddressFromLocation(location) { [weak self] addressText in
                self?.addressPanelView.update(addressText)
            }
        }
    }
    
    func showLocationOnMap(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 500.0
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
}

//MARK: - Layout
extension MapScreenVC {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(pinImageView)
        view.addSubview(addressPanelView)
    }
    func setupConstraints() {
        addressPanelView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            //make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mapView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(addressPanelView.snp.top)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.center.equalTo(mapView)
        }
    }
}

//MARK: - MKMapViewDelegate
extension MapScreenVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        print("did change ->", center)
        
        let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        fetchAddressFromLocation(location) { addressText in
            self.addressPanelView.update(addressText)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        print("will change ->", center)
    }
}
