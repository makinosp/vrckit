//
//  TagModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/03.
//

import Foundation

public enum SystemTag: String, Hashable, Codable {
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

public enum LanguageTag: String, Hashable, Codable {
    case english = "language_eng"
    case korean = "language_kor"
    case russian = "language_rus"
    case spanish = "language_spa"
    case portuguese = "language_por"
    case chinese = "language_zho"
    case german = "language_deu"
    case japanese = "language_jpn"
    case french = "language_fra"
    case swedish = "language_swe"
    case dutch = "language_nld"
    case polish = "language_pol"
    case danish = "language_dan"
    case norwegian = "language_nor"
    case italian = "language_ita"
    case thai = "language_tha"
    case finnish = "language_fin"
    case hungarian = "language_hun"
    case czech = "language_ces"
    case turkish = "language_tur"
    case arabic = "language_ara"
    case romanian = "language_ron"
    case vietnamese = "language_vie"
    case bahasaIndonesia = "language_ind"
    case bahasaMelayu = "language_msa"
    case filipino = "language_fil"
    case mandarinChinese = "language_cmn"
    case hebrew = "language_heb"
    case hmong = "language_hmn"
    case ukrainian = "language_ukr"
    case tokiPona = "language_tok"
    case yueChinese = "language_yue"
    case wuChinese = "language_wuu"
    case americanSignLanguage = "language_ase"
    case britishSignLanguage = "language_bfi"
    case dutchSignLanguage = "language_dse"
    case frenchSignLanguage = "language_fsl"
    case japaneseSignLanguage = "language_jsl"
    case koreanSignLanguage = "language_kvk"
    case noLinguisticContent = "language_zxx"
}

extension LanguageTag: CustomStringConvertible {
    public var description: String {
        switch self {
        case .english: "English"
        case .korean: "한국어"
        case .russian: "Русский"
        case .spanish: "Español"
        case .portuguese: "Português"
        case .chinese: "中文"
        case .german: "Deutsch"
        case .japanese: "日本語"
        case .french: "Français"
        case .swedish: "Svenska"
        case .dutch: "Nederlands"
        case .polish: "Polski"
        case .danish: "Dansk"
        case .norwegian: "Norsk"
        case .italian: "Italiano"
        case .thai: "ภาษาไทย"
        case .finnish: "Suomi"
        case .hungarian: "Magyar"
        case .czech: "Čeština"
        case .turkish: "Türkçe"
        case .arabic: "العربية"
        case .romanian: "Română"
        case .vietnamese: "Tiếng Việt"
        case .bahasaIndonesia: "Bahasa Indonesia"
        case .bahasaMelayu: "Bahasa Melayu"
        case .filipino: "Filipino"
        case .mandarinChinese: "官话"
        case .hebrew: "עברית"
        case .hmong: "Hmoob"
        case .ukrainian: "украї́нська"
        case .tokiPona: "toki pona"
        case .yueChinese: "廣東話"
        case .wuChinese: "吳語"
        case .americanSignLanguage: "American Sign Language"
        case .britishSignLanguage: "British Sign Language"
        case .dutchSignLanguage: "Dutch Sign Language"
        case .frenchSignLanguage: "French Sign Language"
        case .japaneseSignLanguage: "日本手話"
        case .koreanSignLanguage: "한국 수화 언어"
        case .noLinguisticContent: "No linguistic content"
        }
    }
}

extension SystemTag: Identifiable {
    public var id: Int { hashValue }
}

extension LanguageTag: Identifiable {
    public var id: Int { hashValue }
}