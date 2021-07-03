//
//  PhotosListViewControllerTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 30/06/21.
//

import XCTest
import UIKit
import FBSnapshotTestCase

class BaseSnapshotTest: FBSnapshotTestCase {

    // MARK: - Override
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    // MARK: - Public Methods
    
    public func verifySnapshotView(delay: TimeInterval = 0, tolerance: CGFloat = 0.005, identifier: String = "", file: StaticString = #file, line: UInt = #line, view: @escaping () -> UIView?) {
        sleepTest(for: delay)
        
        guard let view = view() else {
            XCTFail("could not fetch view", file: file, line: line)
            return
        }
        
        let image = image(from: view)
        folderName = customFolderName(file: file)
        let customIdentifier = "\(identifier)_\(UIDevice.current.name.replacingOccurrences(of: " ", with: ""))"
        FBSnapshotVerifyView(UIImageView(image: image),
                             identifier: customIdentifier,
                             suffixes: NSOrderedSet(array: ["_64"]),
                             perPixelTolerance: 0.005,
                             overallTolerance: tolerance,
                             file: file,
                             line: line
        )
    }
    
    public func sleepTest(for delay: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        guard delay > 0 else { return }
        let delayExpectation = XCTestExpectation(description: "failed to wait for " + String(delay))
        delayExpectation.assertForOverFulfill = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            delayExpectation.fulfill()
        }
        wait(for: [delayExpectation], timeout: 1 + delay)
    }
    
    // MARK: - Private Methods
    
    private func image(from view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let contextImage = UIGraphicsGetCurrentContext() else { return UIImage() }
        view.layer.render(in: contextImage)
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return UIImage() }
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image)
    }
    
    private func customFolderName(file: StaticString) -> String {
        let fileName = String(describing: type(of: self))
        let methodName: String = invocation?.selector.description ?? ""
        return "\(fileName)/\(methodName)"
    }
}
