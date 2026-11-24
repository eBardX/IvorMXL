// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserIdentificationTests {
}

// MARK: -

extension MXLParserIdentificationTests {
    @Test
    func parseCredit() throws {
        let credit = try MXLParser.parseCredit(node(#"""
            <credit page="1"><credit-type>title</credit-type>
            <credit-words default-x="600" default-y="1500" justify="center" font-size="24">Sonata</credit-words>
            <credit-words>in C</credit-words></credit>
            """#))

        #expect(credit.page == 1)
        #expect(credit.kind == ["title"])
    }

    @Test
    func parseDefaults() throws {
        let defaults = try MXLParser.parseDefaults(node(#"""
            <defaults><scaling><millimeters>7</millimeters><tenths>40</tenths></scaling><concert-score/><page-layout>
            <page-height>1700</page-height><page-width>1200</page-width></page-layout><music-font font-family="Bravura"/>
            <word-font font-family="Garamond" font-size="10"/><lyric-font number="1" font-size="9"/>
            <lyric-language number="1" xml:lang="de"/></defaults>
            """#))

        #expect(defaults.scaling?.millimeters == 7)
        #expect(defaults.isConcertScore)
        #expect(defaults.lyricFont.count == 1)
        #expect(defaults.lyricLanguage.first?.xmlLang == "de")
    }

    @Test
    func parseEncodingItem_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseEncodingItem(node(#"<creator>x</creator>"#))
        }
    }

    @Test
    func parseIdentification() throws {
        let identification = try MXLParser.parseIdentification(node(#"""
            <identification><creator type="composer">Fanny Hensel</creator><rights>Public domain</rights><encoding>
            <software>IvorMXL</software><encoding-date>2026-11-24</encoding-date>
            <supports element="accidental" type="yes"/></encoding><source>Autograph</source>
            <relation type="arrangement">op. 8</relation><miscellaneous>
            <miscellaneous-field name="difficulty">3</miscellaneous-field></miscellaneous></identification>
            """#))

        #expect(identification.creator.map(\.value) == ["Fanny Hensel"])
        #expect(identification.source == "Autograph")
        #expect(identification.encoding?.items.count == 3)
        #expect(identification.miscellaneous?.field.first?.name == "difficulty")
    }

    @Test
    func parseMiscellaneousField_missingNameThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseMiscellaneousField(node(#"<miscellaneous-field>3</miscellaneous-field>"#))
        }
    }

    @Test
    func parseSupports_missingElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseSupports(node(#"<supports type="no"/>"#))
        }
    }

    @Test
    func parseWork() throws {
        let work = try MXLParser.parseWork(node(#"<work><work-number>D. 911</work-number><work-title>Winterreise</work-title></work>"#))

        #expect(work.number == "D. 911")
        #expect(work.title == "Winterreise")
    }
}
