//
//  LanguageTagModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/22.
//

public enum LanguageTag: String, Hashable, Codable, Sendable, CaseIterable {
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

extension LanguageTag: Identifiable {
    public var id: String { rawValue }
}
