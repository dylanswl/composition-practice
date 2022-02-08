//
//  Composition.swift
//  Composition
//
//  Created by Dylan Sewell on 2/7/22.
//

import UIKit

protocol FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { loadedItems in
            // update UI
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // do something
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // do something
    }
}

struct Reachability {
    static let networkAvailable = false
}

class RemoteWithLocalFallbackLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        let load =  Reachability.networkAvailable ?
            remote.loadFeed : local.loadFeed
        load(completion)
    }
}

let vc = FeedViewController(loader: RemoteFeedLoader())
let vc2 = FeedViewController(loader: LocalFeedLoader())
let vc3 = FeedViewController(loader: RemoteWithLocalFallbackLoader(
                                remote: RemoteFeedLoader(),
                                local: LocalFeedLoader()))


