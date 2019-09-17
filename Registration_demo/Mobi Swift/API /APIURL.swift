//
//  APIURL.swift
//  SeeFO
//
//  Created by TBS17 on 02/10/18.
//  Copyright © 2018 Techcronus Bussiness Solutions. All rights reserved.
//

import Foundation

let kPOST = "POST"
let kGET = "GET"

let appJson = "application/json"
let appForm = "application/x-www-form-urlencoded"
let appMultiPart = "multipart/form-data"

//MARK: - Web Services Constant
struct WebURL {
    static let headerKey = "Auth"
    static let headerValue = "ODDS_CLUB#AUTH"
    
    static let langKey = "lang"
    static let langValue = "en"
    
    static let baseTestURL = "http://192.168.1.123/odds_club/api/"
    //static let baseTestStagingURL = "https://techcronus.com/staging/odds_club/api/"
    //static let baseLiveURL = "http://167.86.100.89/admin/api/"
    static let baseLiveURL = "http://admin.oddsclub.eu/api/"
    
    static let baseURL = baseTestURL
    
    static let deviceToken = baseURL + "users/device_token"
    static let welcomeImage = baseURL + "intro/intro-list"
    static let login = baseURL + "users/login"
    static let fblogin = baseURL + "users/fb-login"
    static let register = baseURL + "users/user-registration"
    static let checkOtp = baseURL + "users/check-otp"
    static let resendOtp = baseURL + "users/resend-otp"
    static let forgotPassword = baseURL + "users/forgot-password"
    static let resetPassword = baseURL + "users/reset-password"
    
    static let getUserProfile = baseURL + "users/get-profile"
    static let updateUserProfile = baseURL + "users/update-profile"
    static let getBadgeList = baseURL + "badge/get-badge"
    static let logout = baseURL + "users/logout"
    
    static let getNewsList = baseURL + "news/get-news"
    
    static let gameSetting = baseURL + "users/game_settings"
    static let termsCondition = baseURL + "term-condition"
    static let sendTermCondition = baseURL + "send-term-condition"
    static let getFAQ = baseURL + "faq/get-faq"
    static let getTopic = baseURL + "faq/get-topic"
    static let sendFaqSupport = baseURL + "faq/faq-support"
    static let sendFeatureSupport = baseURL + "faq/features-support"
    static let getSettings = baseURL + "setting"
    static let saveSubscription = baseURL + "subscription/save"
    
    
    static let getCountry = baseURL + "users/country"
    static let getSports = baseURL + "league/get-sports"
    static let getLeagues = baseURL + "league/get-league"
    static let createLeagues = baseURL + "league/save-league"
    static let getAllLeaguesList = baseURL + "league/list-league"
    static let editLeagues = baseURL + "league/edit-league"
    
    static let sendLeagueEmailInvitation = baseURL + "league/send-invitation"
    static let getUserList = baseURL + "users/user_list"
    static let AddCoAdminUser = baseURL + "league/add-admin"
    
    static let GetMatchesForLeagues = baseURL + "league/get-match"
    static let addMatchesToCouponRound = baseURL + "league/add-round"
    static let getRound = baseURL + "league/get-round"
    
    static let getPrivateLeagues = baseURL + "league/private-league-list"
    static let requestJoinPrivateLeague = baseURL + "league/join-Request"
    static let getRequestJoinPrivateLeague = baseURL + "league/join-user-list"
    static let submitRequestToJoinLeague = baseURL + "league/admin-action"
    static let getRoundUserSelection = baseURL + "league/get-round-user-selection"
    static let getRoundResultUserList = baseURL + "league/user-league-with-result"
    static let getCompletedLeagueList = baseURL + "league/completed-league-list"
    static let addUserRound = baseURL + "league/add-user-round"
    
    static let joinedPrivateLeagueList = baseURL + "league/entered-private-league-list"
    static let specificLeaguePlayerList = baseURL + "league/user-league-list"
    static let getPublicLeagues = baseURL + "league/public-league-list"
    static let joinedPublicLeagueList = baseURL + "league/entered-public-league-list"
    
    static let advertisementList = baseURL + "common/ads-list"
    static let advertisementAnalytics = baseURL + "common/ad_analytics"
    static let sendMessagePush = baseURL + "league/send-message"
    static let getFormerLeague = baseURL + "league/former-league"
    
    static let requestAbuse = baseURL + "abuse/request-abuse"
    static let SendRequestAbuse = baseURL + "league/former-league-invitation"
    static let removeMatchFromRound = baseURL + "league/remove-match"
    
    static let getSubScriptionDetail = baseURL + "subscription/get-details"
}
