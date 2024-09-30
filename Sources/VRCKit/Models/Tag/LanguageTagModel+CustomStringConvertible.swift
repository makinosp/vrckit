//
//  LanguageTag+CustomStringConvertible.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/02.
//

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
