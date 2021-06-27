//
//  Debouncer.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import Foundation

final class Debouncer {
    
    // MARK: Typealias
    
    typealias Handler = () -> Void
    
    // MARK: - Public Properties
    
    var handler: Handler?
    
    // MARK: - Private Properties
    
    private let timeInterval: TimeInterval
    private var timer: Timer?
    
    // MARK: - Initializer
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    // MARK: - Public Methods
    
    func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            self.handleTimer(timer)
        }
    }
    
    // MARK: - Private Methods
    
    private func handleTimer(_ timer: Timer) {
        guard timer.isValid else { return }
        handler?()
        handler = nil
    }
}
