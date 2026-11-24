// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterCommon2Tests {
}

// MARK: -

extension MXLFormatterWriterCommon2Tests {
    @Test
    func formatAccidentalValue_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLAccidentalValue] = [.arrowDown,
                                            .arrowUp,
                                            .doubleSharp,
                                            .doubleSharpDown,
                                            .doubleSharpUp,
                                            .doubleSlashFlat,
                                            .flat,
                                            .flat1,
                                            .flat2,
                                            .flat3,
                                            .flat4,
                                            .flatDown,
                                            .flatFlat,
                                            .flatFlatDown,
                                            .flatFlatUp,
                                            .flatUp,
                                            .koron,
                                            .natural,
                                            .naturalDown,
                                            .naturalFlat,
                                            .naturalSharp,
                                            .naturalUp,
                                            .other,
                                            .quarterFlat,
                                            .quarterSharp,
                                            .sharp,
                                            .sharp1,
                                            .sharp2,
                                            .sharp3,
                                            .sharp5,
                                            .sharpDown,
                                            .sharpSharp,
                                            .sharpUp,
                                            .slashFlat,
                                            .slashQuarterSharp,
                                            .slashSharp,
                                            .sori,
                                            .threeQuartersFlat,
                                            .threeQuartersSharp,
                                            .tripleFlat,
                                            .tripleSharp]

        for value in values {
            #expect(MXLParser.parseAccidentalValue(writer.formatAccidentalValue(value)) == value)
        }
    }

    @Test
    func formatEnclosureShape_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLEnclosureShape] = [.bracket,
                                           .circle,
                                           .decagon,
                                           .diamond,
                                           .heptagon,
                                           .hexagon,
                                           .invertedBracket,
                                           .nonagon,
                                           .unenclosed,
                                           .octagon,
                                           .oval,
                                           .pentagon,
                                           .rectangle,
                                           .square,
                                           .triangle]

        for value in values {
            #expect(MXLParser.parseEnclosureShape(writer.formatEnclosureShape(value)) == value)
        }
    }

    @Test
    func formatLineEnd_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLLineEnd] = [.arrow, .both, .down, .plain, .up]

        for value in values {
            #expect(MXLParser.parseLineEnd(writer.formatLineEnd(value)) == value)
        }
    }

    @Test
    func formatTextDirection_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLTextDirection] = [.lro, .ltr, .rlo, .rtl]

        for value in values {
            #expect(MXLParser.parseTextDirection(writer.formatTextDirection(value)) == value)
        }
    }

    @Test
    func formatUpDownStopContinue_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLUpDownStopContinue] = [.continue, .down, .stop, .up]

        for value in values {
            #expect(MXLParser.parseUpDownStopContinue(writer.formatUpDownStopContinue(value)) == value)
        }
    }

    @Test
    func formatXmlSpace_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLXmlSpace] = [.default, .preserve]

        for value in values {
            #expect(MXLParser.parseXmlSpace(writer.formatXmlSpace(value)) == value)
        }
    }

    @Test
    func formatYesNoNumber_roundTrips() {
        let writer = MXLFormatter.Writer()
        let values: [MXLYesNoNumber] = [.no, .number(2.5), .yes]

        for value in values {
            #expect(MXLParser.parseYesNoNumber(writer.formatYesNoNumber(value)) == value)
        }
    }

    @Test
    func formatYesNoNumber_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLYesNoNumber] = [.no, .yes]

        for value in values {
            #expect(MXLParser.parseYesNoNumber(writer.formatYesNoNumber(value)) == value)
        }
    }

    @Test
    func textDecorationAttributes_omitsNil() {
        #expect(MXLFormatter.Writer().textDecorationAttributes(nil, nil, nil).isEmpty)
    }

    @Test
    func writeEmptyLine_roundTrips() throws {
        let original = try MXLParser.parseEmptyLine(node(#"""
            <scoop line-shape="curved" line-type="dashed" line-length="long" dash-length="2" placement="above"/>
            """#))
        let written = writtenNode { $0.writeEmptyLine(.scoop, original) }

        #expect(try MXLParser.parseEmptyLine(written) == original)
    }

    @Test
    func writeEmptyPrintStyleAlignID_roundTrips() throws {
        let original = try MXLParser.parseEmptyPrintStyleAlignID(node(#"<eyeglasses id="e1" default-y="5" halign="left" valign="top"/>"#))
        let written = writtenNode { $0.writeEmptyPrintStyleAlignID(.eyeglasses, original) }

        #expect(try MXLParser.parseEmptyPrintStyleAlignID(written) == original)
    }

    @Test
    func writeFormattedSymbolID_roundTrips() throws {
        let original = try MXLParser.parseFormattedSymbolID(node(#"<symbol id="s1" font-size="12" enclosure="circle">segno</symbol>"#))
        let written = writtenNode { $0.writeFormattedSymbolID(.symbol, original) }

        #expect(try MXLParser.parseFormattedSymbolID(written) == original)
    }

    @Test
    func writeFormattedText_roundTrips() throws {
        let original = try MXLParser.parseFormattedText(node(#"""
            <words justify="right" font-style="italic" letter-spacing="normal" xml:lang="de" xml:space="preserve" dir="ltr">sehr ruhig</words>
            """#))
        let written = writtenNode { $0.writeFormattedText(.words, original) }

        #expect(try MXLParser.parseFormattedText(written) == original)
    }

    @Test
    func writeFormattedTextID_roundTrips() throws {
        let original = try MXLParser.parseFormattedTextID(node(#"""
            <rehearsal id="r1" enclosure="square" line-through="1" rotation="10">A</rehearsal>
            """#))
        let written = writtenNode { $0.writeFormattedTextID(.rehearsal, original) }

        #expect(try MXLParser.parseFormattedTextID(written) == original)
    }

    @Test
    func writeImage_roundTrips() throws {
        let original = try MXLParser.parseImage(node(#"<image id="i1" source="logo.png" type="image/png" height="40" width="80" valign="middle"/>"#))
        let written = writtenNode { $0.writeImage(.image, original) }

        #expect(try MXLParser.parseImage(written) == original)
    }

    @Test
    func writeOtherPlacementText_roundTrips() throws {
        let original = try MXLParser.parseOtherPlacementText(node(#"""
            <other-articulation placement="below" smufl="articTenutoBelow">t</other-articulation>
            """#))
        let written = writtenNode { $0.writeOtherPlacementText(.otherArticulation, original) }

        #expect(try MXLParser.parseOtherPlacementText(written) == original)
    }

    @Test
    func writePlacementText_roundTrips() throws {
        let original = try MXLParser.parsePlacementText(node(#"<fingering placement="above" default-y="3">2</fingering>"#))
        let written = writtenNode { $0.writePlacementText(.fingering, original) }

        #expect(try MXLParser.parsePlacementText(written) == original)
    }

    @Test
    func writeStyleText_roundTrips() throws {
        let original = try MXLParser.parseStyleText(node(##"<tuplet-number font-size="8" color="#112233">3</tuplet-number>"##))
        let written = writtenNode { $0.writeStyleText(.tupletNumber, original) }

        #expect(try MXLParser.parseStyleText(written) == original)
    }

    @Test
    func writeTextElementData_roundTrips() throws {
        let original = try MXLParser.parseTextElementData(node(#"""
            <text font-family="Garamond" overline="2" letter-spacing="0.5" xml:lang="fr" dir="rtl">la</text>
            """#))
        let written = writtenNode { $0.writeTextElementData(.text, original) }

        #expect(try MXLParser.parseTextElementData(written) == original)
    }

    @Test
    func writeTypedText_roundTrips() throws {
        let original = try MXLParser.parseTypedText(node(#"<creator type="lyricist">Heine</creator>"#))
        let written = writtenNode { $0.writeTypedText(.creator, original) }

        #expect(try MXLParser.parseTypedText(written) == original)
    }
}
