//
//  Feed.swift
//  GetStream
//
//  Created by Alexey Bukhtin on 09/11/2018.
//  Copyright © 2018 Stream.io Inc. All rights reserved.
//

import Foundation
import Moya
import Result

/// - feedSlug: the name of the feed group, for instance user, trending, flat, timeline etc. For example: flat, timeline
/// - userId: the owner of the given feed.
public typealias FeedId = (feedSlug: String, userId: String)

public struct Feed {
    private let feedId: FeedId
    private let client: Client
    
    private var feedCancelling: Moya.Cancellable?
    
    public init(_ feedId: FeedId, client: Client) {
        self.feedId = feedId
        self.client = client
    }
}

// MARK: - Activities

extension Feed {
    /// Retrieve feed activities.
    ///
    /// - parameters:
    ///     - pagination: a pagination options
    ///     - completion: a completion handler
    /// - returns: a cancellable object to cancel the request
    @discardableResult
    public mutating func feed(pagination: FeedPagination = .none, completion: @escaping Completion<Activity>) -> Cancellable {
        if let feedCancelling = feedCancelling, !feedCancelling.isCancelled {
            feedCancelling.cancel()
        }
        
        let cancelling = client.request(endpoint: FeedEndpoint.feed(feedId, pagination: pagination)) { [self] result in
            if case .success(let json) = result {
                self.parseFeed(json, completion: completion)
            } else if case .failure(let error) = result {
                completion(.failure(error))
            }
        }
        
        feedCancelling = cancelling
        
        return cancelling
    }
    
    private func parseFeed(_ json: JSON, completion: @escaping Completion<Activity>) {
        
    }
}