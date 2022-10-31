//
//  ColorPaletteView.swift
//  HW
//
//  Created by Никита Артемов on 26.10.2022.
//

import Foundation
import UIKit

final class ColorPaletteView: UIControl {
    internal let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        layer.cornerRadius = 12
        let redControl = ColorSliderView(colorName: "R", value: Float(chosenColor.rgba.redComponent))
        let greenControl = ColorSliderView(colorName: "G", value: Float(chosenColor.rgba.greenComponent))
        let blueControl = ColorSliderView(colorName: "B", value: Float(chosenColor.rgba.blueComponent))
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                    for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pinLeft(to: self, 12)
        stackView.pinBottom(to: self, 12)
        stackView.pinTop(to: self, 12)
        stackView.pinRight(to: self, 12)
    }

    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            chosenColor = UIColor(
                    red: CGFloat(slider.value),
                    green: chosenColor.rgba.greenComponent, blue: chosenColor.rgba.blueComponent, alpha: chosenColor.rgba.alphaComponent)
        case 1:
            chosenColor = UIColor(
                    red: chosenColor.rgba.redComponent, green: CGFloat(slider.value), blue: chosenColor.rgba.blueComponent, alpha: chosenColor.rgba.alphaComponent)
        default:
            chosenColor = UIColor(
                    red: chosenColor.rgba.redComponent, green: chosenColor.rgba.greenComponent, blue: CGFloat(slider.value), alpha: chosenColor.rgba.alphaComponent)
        }
        sendActions(for: .touchDragInside)
    }
}
