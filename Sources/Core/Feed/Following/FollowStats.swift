//
//  FollowStats.swift
//  GetStream_ios
//
//  Created by Artem Goryaev on 2022-11-24.
//

import Foundation

/// A feed follow stats.
public struct FollowStats: Decodable {
    public let followers: FollowStat
    public let following: FollowStat
}

public struct FollowStat: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case feedId = "feed"
    }
    
    public let count: Int
    public let feedId: FeedId
}
