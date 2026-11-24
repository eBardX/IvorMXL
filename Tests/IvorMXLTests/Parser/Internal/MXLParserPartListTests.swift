// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserPartListTests {
}

// MARK: -

extension MXLParserPartListTests {
    @Test
    func parseGroupBarlineValue_invalidValue() {
        #expect(MXLParser.parseGroupBarlineValue("bogus") == nil)
    }

    @Test
    func parseGroupBarlineValue_validValues() {
        #expect(MXLParser.parseGroupBarlineValue("Mensurstrich") == .mensurstrich)
        #expect(MXLParser.parseGroupBarlineValue("no") == .no)
        #expect(MXLParser.parseGroupBarlineValue("yes") == .yes)
    }

    @Test
    func parseGroupSymbolValue_invalidValue() {
        #expect(MXLParser.parseGroupSymbolValue("bogus") == nil)
    }

    @Test
    func parseGroupSymbolValue_validValues() {
        #expect(MXLParser.parseGroupSymbolValue("brace") == .brace)
        #expect(MXLParser.parseGroupSymbolValue("bracket") == .bracket)
        #expect(MXLParser.parseGroupSymbolValue("line") == .line)
        #expect(MXLParser.parseGroupSymbolValue("none") == .unmarked)
        #expect(MXLParser.parseGroupSymbolValue("square") == .square)
    }

    @Test
    func parseInstrument_missingIDThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseInstrument(node(#"<instrument/>"#))
        }
    }

    @Test
    func parsePartGroup() throws {
        let group = try MXLParser.parsePartGroup(node(#"""
            <part-group type="start" number="1"><group-name justify="left">Strings</group-name>
            <group-abbreviation>Str.</group-abbreviation><group-symbol default-x="-7">bracket</group-symbol>
            <group-barline>yes</group-barline><group-time/></part-group>
            """#))

        #expect(group.kind == .start)
        #expect(group.number == "1")
        #expect(group.symbol?.value == .bracket)
        #expect(group.barline?.value == .yes)
        #expect(group.stretchesTimeSignature)
    }

    @Test
    func parsePartList() throws {
        let partList = try MXLParser.parsePartList(node(#"""
            <part-list><part-group type="start" number="1"><group-name justify="left">Strings</group-name>
            <group-abbreviation>Str.</group-abbreviation><group-symbol default-x="-7">bracket</group-symbol>
            <group-barline>yes</group-barline><group-time/></part-group><score-part id="P1">
            <part-name print-object="no">Violin</part-name><part-abbreviation>Vln.</part-abbreviation><group>score</group>
            <score-instrument id="P1-I1"><instrument-name>Violin</instrument-name>
            <instrument-sound>strings.violin</instrument-sound><solo/></score-instrument><player id="P1-M1">
            <player-name>Soloist</player-name></player><midi-device port="1">SoundFont</midi-device>
            <midi-instrument id="P1-I1"><midi-channel>1</midi-channel><midi-program>41</midi-program><volume>80</volume>
            <pan>-45</pan></midi-instrument></score-part><part-group type="stop" number="1"/></part-list>
            """#))

        #expect(partList.items.count == 3)
    }

    @Test
    func parsePartList_withoutScorePartThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePartList(node(#"<part-list><part-group type="start"/></part-list>"#))
        }
    }

    @Test
    func parsePartListItem_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePartListItem(node(#"<part-name>x</part-name>"#))
        }
    }

    @Test
    func parsePartSymbol() throws {
        let symbol = try MXLParser.parsePartSymbol(node(#"<part-symbol top-staff="1" bottom-staff="2">brace</part-symbol>"#))

        #expect(symbol.value == .brace)
        #expect(symbol.topStaff?.uintValue == 1)
        #expect(symbol.bottomStaff?.uintValue == 2)
    }

    @Test
    func parsePlayer_missingNameThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePlayer(node(#"<player id="M1"/>"#))
        }
    }

    @Test
    func parseScorePart() throws {
        let part = try MXLParser.parseScorePart(node(#"""
            <score-part id="P1"><part-name print-object="no">Violin</part-name><part-abbreviation>Vln.</part-abbreviation>
            <group>score</group><score-instrument id="P1-I1"><instrument-name>Violin</instrument-name>
            <instrument-sound>strings.violin</instrument-sound><solo/></score-instrument><player id="P1-M1">
            <player-name>Soloist</player-name></player><midi-device port="1">SoundFont</midi-device>
            <midi-instrument id="P1-I1"><midi-channel>1</midi-channel><midi-program>41</midi-program><volume>80</volume>
            <pan>-45</pan></midi-instrument></score-part>
            """#))

        #expect(part.id == "P1")
        #expect(part.group == ["score"])
        #expect(part.instrument.first?.name == "Violin")
        #expect(part.player.first?.name == "Soloist")
        #expect(part.group2.count == 1)
        #expect(part.group2.first?.midiDevice?.value == "SoundFont")
        #expect(part.group2.first?.midiInstrument?.id == "P1-I1")
    }

    @Test
    func parseScorePart_missingPartNameThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseScorePart(node(#"<score-part id="P1"/>"#))
        }
    }
}
