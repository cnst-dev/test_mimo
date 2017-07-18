//
//  Constraintable.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 15.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit

protocol Constraintable {

    var width: Int { get }
    var height: Int { get }
}

extension Constraintable where Self: UIView {

    private var widthKey: String {
        return "width"
    }

    private var heightKey: String {
        return "height"
    }

    private var metrics: [String: Int] {
        return [widthKey: width, heightKey: height]
    }

    /// A center constraint in the superview.
    var centerContsraint: NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: superview,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
        )
    }

    /// Width constraints described by an ASCII art-like visual format string.
    ///
    /// - Parameter key: A view name key for a visual format string.
    /// - Returns: An array of width constraints.
    func widthConstraints(for key: String) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(
            withVisualFormat: formatWidthConstraint(for: key),
            options: [],
            metrics: metrics,
            views: [key: self]
        )
    }

    /// Height constraints described by an ASCII art-like visual format string.
    ///
    /// - Parameter key: A view name key for a visual format string.
    /// - Returns: An array of height constraints.
    func heightConstraints(for key: String) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(
            withVisualFormat: formatHeightConstraint(for: key),
            options: [],
            metrics: metrics,
            views: [key: self]
        )
    }

    /// Makes a format specification for width constraints with a view key name.
    ///
    /// - Parameter viewKey: A view name key for a visual format string.
    /// - Returns: A format specification for width constraints with a view key name.
    private func formatWidthConstraint(for viewKey: String) -> String {
        return "[\(viewKey)(\(widthKey))]"
    }

    /// Makes a format specification for height constraints with a view key name.
    ///
    /// - Parameter viewKey: A view name key for a visual format string.
    /// - Returns: A format specification for height constraints with a view key name.
    private func formatHeightConstraint(for viewKey: String) -> String {
        return "V:[\(viewKey)(\(heightKey))]"
    }
}
