//
//  ViewController.swift
//  SpringApp
//
//  Created by Александр Астапенко on 8.04.22.
//

import Spring
import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    // MARK: Internal
    private let picker = UIPickerView()
    private var pickerAccessory: UIToolbar?
    @IBOutlet var imageViewCore: SpringView!
    @IBOutlet var titleName: UILabel!
    @IBOutlet var curveLbl: UILabel!
    @IBOutlet var delayLbl: UILabel!
    @IBOutlet var durationLbl: UILabel!
    @IBOutlet var forceLbl: UILabel!
    @IBOutlet var changeAnimate: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        setToolBarBtn()
        imageViewCore.layer.cornerRadius = imageViewCore.frame.height / 2
    }

    @IBAction func startAnimation(_: Any) {
        setUpAnimation()
        imageViewCore.animate()
    }

    @objc func cancelBtnClicked(_: UIBarButtonItem?) {
        changeAnimate?.resignFirstResponder()
    }

    @objc func doneBtnClicked(_: UIBarButtonItem?) {
        imageViewCore.animation = Data.animationArray[picker.selectedRow(inComponent: 0)]
        changeAnimate.text = Data.animationArray[picker.selectedRow(inComponent: 0)]
        titleName.text = changeAnimate.text
        changeAnimate?.resignFirstResponder()
    }

    // MARK: Private

    private func setToolBarBtn() {
        changeAnimate.inputView = picker
        pickerAccessory = UIToolbar()
        pickerAccessory?.autoresizingMask = .flexibleHeight
        pickerAccessory?.barStyle = .default
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.black
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.black
        pickerAccessory?.items = [cancelButton, flexSpace, doneButton]
        changeAnimate.inputAccessoryView = pickerAccessory
    }

    private func setUpAnimation() {
        imageViewCore.delay = CGFloat.random(in: 0 ... 3)
        imageViewCore.curve = Data.curveArray[Int.random(in: 0 ... Data.curveArray.count - 1)]
        imageViewCore.force = CGFloat.random(in: 0 ... 3)
        imageViewCore.duration = CGFloat.random(in: 0 ... 3)
        durationLbl.text = String(format: "%.2f", imageViewCore.duration)
        curveLbl.text = imageViewCore.curve
        delayLbl.text = String(format: "%.2f", imageViewCore.delay)
        forceLbl.text = String(format: "%.2f", imageViewCore.force)
        imageViewCore.repeatCount = 3
        imageViewCore.backgroundColor = UIColor(red: CGFloat.random(in: 0 ... 1),
                                                green: CGFloat.random(in: 0 ... 1),
                                                blue: CGFloat.random(in: 0 ... 1),
                                                alpha: 1)
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return Data.animationArray.count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return Data.animationArray[row]
    }
}
