// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterIdentificationTests {
}

// MARK: -

extension MXLFormatterWriterIdentificationTests {
    @Test
    func writeCredit_roundTrips() throws {
        let original = try MXLParser.parseCredit(node(#"""
            <credit page="1"><credit-type>title</credit-type>
            <credit-words default-x="600" default-y="1500" justify="center" font-size="24">Sonata</credit-words>
            <credit-words>in C</credit-words></credit>
            """#))
        let written = writtenNode { $0.writeCredit(original) }

        #expect(try MXLParser.parseCredit(written) == original)
    }

    @Test
    func writeCredit_symbolRoundTrips() throws {
        let original = try MXLParser.parseCredit(node(#"<credit><credit-symbol default-x="10" default-y="20">segno</credit-symbol></credit>"#))
        let written = writtenNode { $0.writeCredit(original) }

        #expect(try MXLParser.parseCredit(written) == original)
    }

    @Test
    func writeDefaults_roundTrips() throws {
        let original = try MXLParser.parseDefaults(node(#"""
            <defaults><scaling><millimeters>7</millimeters><tenths>40</tenths></scaling><concert-score/><page-layout>
            <page-height>1700</page-height><page-width>1200</page-width></page-layout><music-font font-family="Bravura"/>
            <word-font font-family="Garamond" font-size="10"/><lyric-font number="1" font-size="9"/>
            <lyric-language number="1" xml:lang="de"/></defaults>
            """#))
        let written = writtenNode { $0.writeDefaults(original) }

        #expect(try MXLParser.parseDefaults(written) == original)
    }

    @Test
    func writeEncoding_roundTrips() throws {
        let original = try MXLParser.parseEncoding(node(#"""
            <encoding><encoder type="transcriber">JGP</encoder><encoding-description>hand</encoding-description>
            </encoding>
            """#))
        let written = writtenNode { $0.writeEncoding(original) }

        #expect(try MXLParser.parseEncoding(written) == original)
    }

    @Test
    func writeIdentification_roundTrips() throws {
        let original = try MXLParser.parseIdentification(node(#"""
            <identification><creator type="composer">Fanny Hensel</creator><rights>Public domain</rights><encoding>
            <software>IvorMXL</software><encoding-date>2026-11-24</encoding-date>
            <supports element="accidental" type="yes"/></encoding><source>Autograph</source>
            <relation type="arrangement">op. 8</relation><miscellaneous>
            <miscellaneous-field name="difficulty">3</miscellaneous-field></miscellaneous></identification>
            """#))
        let written = writtenNode { $0.writeIdentification(original) }

        #expect(try MXLParser.parseIdentification(written) == original)
    }

    @Test
    func writeMiscellaneous_roundTrips() throws {
        let original = try MXLParser.parseMiscellaneous(node(#"""
            <miscellaneous><miscellaneous-field name="a">1</miscellaneous-field>
            <miscellaneous-field name="b">2</miscellaneous-field></miscellaneous>
            """#))
        let written = writtenNode { $0.writeMiscellaneous(original) }

        #expect(try MXLParser.parseMiscellaneous(written) == original)
    }

    @Test
    func writeSupports_roundTrips() throws {
        let original = try MXLParser.parseSupports(node(#"<supports type="yes" element="print" attribute="new-page" value="yes"/>"#))
        let written = writtenNode { $0.writeSupports(original) }

        #expect(try MXLParser.parseSupports(written) == original)
    }

    @Test
    func writeWork_roundTrips() throws {
        let original = try MXLParser.parseWork(node(#"""
            <work><work-number>Op. 1</work-number><work-title>Trio</work-title>
            <opus xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="opus.xml"/></work>
            """#))
        let written = writtenNode { $0.writeWork(original) }

        #expect(try MXLParser.parseWork(written) == original)
    }
}
