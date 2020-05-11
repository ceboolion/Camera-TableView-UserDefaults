//
//  ViewController.swift
//  ChallengeDay50
//
//  Created by Ceboolion on 09/05/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private let cellID = "Cell"
  private let userDefault = UserDefaults.standard
  private var images = [Image]()
  
  private let imageTable: UITableView = {
    let table = UITableView()
    table.rowHeight = 80
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    imageTable.delegate = self
    imageTable.dataSource = self
    imageTable.register(ImageViewCell.self, forCellReuseIdentifier: cellID)
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
    decode()
    configureView()
  }
  
  @objc func addImage(){
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    UIImagePickerController.isSourceTypeAvailable(.camera)
    present(imagePicker, animated: true)
  }
  
  private func decode(){
    if let savedData = userDefault.object(forKey: "images") as? Data{
      let jsonDecoder = JSONDecoder()
      do {
        images = try jsonDecoder.decode([Image].self, from: savedData)
      }catch{
        print("Failed to load images.")
      }
    }
  }
  
  private func save(){
    let jsonEncoder = JSONEncoder()
    if let savedData = try? jsonEncoder.encode(images){
      userDefault.set(savedData, forKey: "images")
    } else {
      print("Failed to save images")
    }
  }
  
  private func configureView(){
    view.addSubview(imageTable)
    imageTable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    imageTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    imageTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return images.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ImageViewCell else {
      fatalError("Unable to deque ImageViewCell")
    }
    let image = images[indexPath.row]
    cell.name.text = image.imageName
    let path = getDocumentDirectory().appendingPathComponent(image.image)
    cell.newImage.image = UIImage(contentsOfFile: path.path)
    cell.newImage.layer.cornerRadius = 25
    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
//    cell.name.text = "text"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let image = images[indexPath.row]
    let path = getDocumentDirectory().appendingPathComponent(image.image)
    let detailVC = DeatailImageController()
    detailVC.image.image = UIImage(contentsOfFile: path.path)
    navigationController?.pushViewController(detailVC, animated: true)

  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else {return}
    var imageName = UUID().uuidString
    let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
    if let jpegData = image.jpegData(compressionQuality: 0.8){
      try? jpegData.write(to: imagePath)
    }
    let imageData = Image(imageName: "Picture", image: imageName)
    let ac = UIAlertController(title: "Rename your picture", message: nil, preferredStyle: .alert)
    ac.addTextField()
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] _ in
      guard let title = ac?.textFields?[0].text else {return}
      imageName = title
      self?.imageTable.reloadData()
      self?.save()
    }))
    images.append(imageData)
    imageTable.reloadData()
    dismiss(animated: true)
    save()
  }
  
  func getDocumentDirectory() -> URL{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

