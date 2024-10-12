//
//  SystemTagModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/22.
//

public enum SystemTag: String, Hashable, Codable, Sendable {
    case adminAvatarAccess = "admin_avatar_access"
    case adminCanGrantLicenses = "admin_can_grant_licenses"
    case adminCannyAccess = "admin_canny_access"
    case adminLockTags = "admin_lock_tags"
    case adminLockLevel = "admin_lock_level"
    case adminModerator = "admin_moderator"
    case adminOfficialThumbnail = "admin_official_thumbnail"
    case adminScriptingAccess = "admin_scripting_access"
    case adminWorldAccess = "admin_world_access"
    case showSocialRank = "show_social_rank"
    case showModTag = "show_mod_tag"
    case systemAvatarAccess = "system_avatar_access"
    case systemEarlyAdopter = "system_early_adopter"
    case systemFeedbackAccess = "system_feedback_access"
    case systemNoCaptcha = "system_no_captcha"
    case systemProbableTroll = "system_probable_troll"
    case systemSupporter = "system_supporter"
    case systemTroll = "system_troll"
    case systemTrustBasic = "system_trust_basic"
    case systemTrustKnown = "system_trust_known"
    case systemTrustTrusted = "system_trust_trusted"
    case systemTrustVeteran = "system_trust_veteran"
    case systemWorldAccess = "system_world_access"
}

extension SystemTag: Identifiable {
    public var id: String { rawValue }
}
