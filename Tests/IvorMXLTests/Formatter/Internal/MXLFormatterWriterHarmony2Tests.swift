// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterHarmony2Tests {
}

// MARK: -

extension MXLFormatterWriterHarmony2Tests {
    @Test
    func writeBarre_roundTrips() throws {
        let original = try MXLParser.parseBarre(node(##"<barre type="start" color="#FF0000"/>"##))
        let written = writtenNode { $0.writeBarre(original) }

        #expect(try MXLParser.parseBarre(written) == original)
    }

    @Test
    func writeFigure_roundTrips() throws {
        let original = try MXLParser.parseFigure(node(#"""
            <figure><prefix>sharp</prefix><figure-number font-weight="bold">6</figure-number><suffix>slash</suffix>
            <extend type="stop"/></figure>
            """#))
        let written = writtenNode { $0.writeFigure(original) }

        #expect(try MXLParser.parseFigure(written) == original)
    }

    @Test
    func writeFiguredBass_roundTrips() throws {
        let original = try MXLParser.parseFiguredBass(node(#"""
            <figured-bass parentheses="yes" placement="below"><figure><prefix>flat</prefix>
            <figure-number>6</figure-number><extend type="start"/></figure><figure><figure-number>4</figure-number>
            </figure><duration>2</duration></figured-bass>
            """#))
        let written = writtenNode { $0.writeFiguredBass(original) }

        #expect(try MXLParser.parseFiguredBass(written) == original)
    }

    @Test
    func writeFirstFret_roundTrips() throws {
        let original = try MXLParser.parseFirstFret(node(#"<first-fret text="3fr" location="left">3</first-fret>"#))
        let written = writtenNode { $0.writeFirstFret(original) }

        #expect(try MXLParser.parseFirstFret(written) == original)
    }

    @Test
    func writeFrame_roundTrips() throws {
        let original = try MXLParser.parseFrame(node(#"""
            <frame unplayed="x" height="40" width="30"><frame-strings>6</frame-strings><frame-frets>4</frame-frets>
            <first-fret text="5fr" location="right">5</first-fret><frame-note><string>6</string><fret>1</fret>
            <fingering>1</fingering><barre type="start"/></frame-note><frame-note><string>1</string><fret>1</fret>
            <barre type="stop"/></frame-note></frame>
            """#))
        let written = writtenNode { $0.writeFrame(original) }

        #expect(try MXLParser.parseFrame(written) == original)
    }

    @Test
    func writeFrameNote_roundTrips() throws {
        let original = try MXLParser.parseFrameNote(node(#"""
            <frame-note><string>5</string><fret>3</fret><fingering substitution="yes">3</fingering></frame-note>
            """#))
        let written = writtenNode { $0.writeFrameNote(original) }

        #expect(try MXLParser.parseFrameNote(written) == original)
    }

    @Test
    func writeNumeral_roundTrips() throws {
        let original = try MXLParser.parseNumeral(node(#"""
            <numeral><numeral-root text="IV">4</numeral-root><numeral-alter location="left">-1</numeral-alter>
            <numeral-key print-object="no"><numeral-fifths>-3</numeral-fifths><numeral-mode>harmonic minor</numeral-mode>
            </numeral-key></numeral>
            """#))
        let written = writtenNode { $0.writeNumeral(original) }

        #expect(try MXLParser.parseNumeral(written) == original)
    }

    @Test
    func writeNumeralKey_roundTrips() throws {
        let original = try MXLParser.parseNumeralKey(node(#"""
            <numeral-key><numeral-fifths>2</numeral-fifths><numeral-mode>major</numeral-mode></numeral-key>
            """#))
        let written = writtenNode { $0.writeNumeralKey(original) }

        #expect(try MXLParser.parseNumeralKey(written) == original)
    }

    @Test
    func writeNumeralRoot_roundTrips() throws {
        let original = try MXLParser.parseNumeralRoot(node(#"<numeral-root text="vi">6</numeral-root>"#))
        let written = writtenNode { $0.writeNumeralRoot(original) }

        #expect(try MXLParser.parseNumeralRoot(written) == original)
    }
}
