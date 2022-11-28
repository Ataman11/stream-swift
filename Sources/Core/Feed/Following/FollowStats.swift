//
//  FollowStats.swift
//  GetStream_ios
//
//  Created by Artem Goryaev on 2022-11-24.
//

import Foundation

/// A feed follow stats.
public struct FollowStats: Decodable {
    
    enum CodingKeys: CodingKey {
        case results
    }
    
    private let results: InnterFollowStats
    
    private struct InnterFollowStats: Decodable {
        let followers: FollowStat
        let following: FollowStat
    }
    
    public var followers: FollowStat {
        results.followers
    }
    public var following: FollowStat {
        results.following
    }
}

public struct FollowStat: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case feedId = "feed"
    }
    
    public let count: Int
    public let feedId: FeedId
}
