//
//  UIFont.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 18/06/21.
//

import UIKit

extension UIFont {

  static func font(type: FontType, textStyle: UIFont.TextStyle) -> UIFont {
    let customFontSizeDictionary: [UIFont.TextStyle: CGFloat] = [
      .largeTitle: 34,
      .title1: 28,
      .title2: 22,
      .title3: 20,
      .headline: 17,
      .body: 17,
      .callout: 16,
      .subheadline: 15,
      .footnote: 13,
      .caption1: 12,
      .caption2: 11
    ]
    let size: CGFloat = customFontSizeDictionary[textStyle] ?? .zero
    let fontMetrics = UIFontMetrics(forTextStyle: textStyle)

    let font = UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    return fontMetrics.scaledFont(for: font)
  }

  enum FontType: String {
    case semiBold = "NewYorkMedium-Semibold"
    case regular = "NewYorkMedium-Regular"
    case bold = "NewYork-Bold"
  }
}
