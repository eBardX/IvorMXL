// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserPlaybackTests {
}

// MARK: -

extension MXLParserPlaybackTests {
    @Test
    func parseAssess_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseAssess(node(#"<assess/>"#))
        }
    }

    @Test
    func parseListening() throws {
        let listening = try MXLParser.parseListening(node(#"""
            <listening><sync type="event" latency="20" player="P1"/>
            <other-listening type="cue" time-only="1">x</other-listening><offset sound="yes">2</offset></listening>
            """#))

        #expect(listening.items.count == 2)
        #expect(listening.offset?.affectsPlayback == true)
    }

    @Test
    func parseMidi16_validAndInvalid() {
        #expect(MXLParser.parseMidi16("16")?.uintValue == 16)
        #expect(MXLParser.parseMidi16("17") == nil)
    }

    @Test
    func parseMidiInstrument() throws {
        let instrument = try MXLParser.parseMidiInstrument(node(#"""
            <midi-instrument id="I1"><midi-channel>10</midi-channel><midi-unpitched>36</midi-unpitched>
            <elevation>15</elevation></midi-instrument>
            """#))

        #expect(instrument.midiChannel?.uintValue == 10)
        #expect(instrument.midiUnpitched?.uintValue == 36)
        #expect(instrument.elevation == 15)
    }

    @Test
    func parseMute_invalidValue() {
        #expect(MXLParser.parseMute("bogus") == nil)
    }

    @Test
    func parseMute_validValues() {
        #expect(MXLParser.parseMute("bucket") == .bucket)
        #expect(MXLParser.parseMute("cup") == .cup)
        #expect(MXLParser.parseMute("echo") == .echo)
        #expect(MXLParser.parseMute("harmon-no-stem") == .harmonNoStem)
        #expect(MXLParser.parseMute("harmon-stem") == .harmonStem)
        #expect(MXLParser.parseMute("hat") == .hat)
        #expect(MXLParser.parseMute("off") == .off)
        #expect(MXLParser.parseMute("on") == .on)
        #expect(MXLParser.parseMute("palm") == .palm)
        #expect(MXLParser.parseMute("plunger") == .plunger)
        #expect(MXLParser.parseMute("practice") == .practice)
        #expect(MXLParser.parseMute("solotone") == .solotone)
        #expect(MXLParser.parseMute("stop-hand") == .stopHand)
        #expect(MXLParser.parseMute("stop-mute") == .stopMute)
        #expect(MXLParser.parseMute("straight") == .straight)
    }

    @Test
    func parsePlay() throws {
        let play = try MXLParser.parsePlay(node(#"""
            <play id="P1-I1"><ipa>a</ipa><mute>straight</mute><semi-pitched>high</semi-pitched>
            <other-play type="x">z</other-play></play>
            """#))

        #expect(play.items.count == 4)
        #expect(play.items.first == .ipa("a"))
    }

    @Test
    func parseSemiPitched_invalidValue() {
        #expect(MXLParser.parseSemiPitched("bogus") == nil)
    }

    @Test
    func parseSemiPitched_validValues() {
        #expect(MXLParser.parseSemiPitched("high") == .high)
        #expect(MXLParser.parseSemiPitched("low") == .low)
        #expect(MXLParser.parseSemiPitched("medium") == .medium)
        #expect(MXLParser.parseSemiPitched("medium-high") == .mediumHigh)
        #expect(MXLParser.parseSemiPitched("medium-low") == .mediumLow)
        #expect(MXLParser.parseSemiPitched("very-low") == .veryLow)
    }

    @Test
    func parseSound() throws {
        let sound = try MXLParser.parseSound(node(#"""
            <sound tempo="96" dacapo="yes" damper-pedal="yes"><swing><first>2</first><second>1</second>
            <swing-type>eighth</swing-type></swing></sound>
            """#))

        #expect(sound.tempo == 96)
        #expect(sound.isDaCapo == true)
        #expect(sound.swing?.content == .first(2, second: 1, kind: .eighth))
    }

    @Test
    func parseSwing_straight() throws {
        let swing = try MXLParser.parseSwing(node("<swing><straight/><swing-style>bossa</swing-style></swing>"))

        #expect(swing.content == .straight)
        #expect(swing.style == "bossa")
    }

    @Test
    func parseSwingKind_invalidValue() {
        #expect(MXLParser.parseSwingKind("bogus") == nil)
    }

    @Test
    func parseSwingKind_validValues() {
        #expect(MXLParser.parseSwingKind("16th") == .n16th)
        #expect(MXLParser.parseSwingKind("eighth") == .eighth)
    }

    @Test
    func parseSync_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseSync(node(#"<sync/>"#))
        }
    }

    @Test
    func parseSyncKind_invalidValue() {
        #expect(MXLParser.parseSyncKind("bogus") == nil)
    }

    @Test
    func parseSyncKind_validValues() {
        #expect(MXLParser.parseSyncKind("always-event") == .alwaysEvent)
        #expect(MXLParser.parseSyncKind("event") == .event)
        #expect(MXLParser.parseSyncKind("mostly-event") == .mostlyEvent)
        #expect(MXLParser.parseSyncKind("mostly-tempo") == .mostlyTempo)
        #expect(MXLParser.parseSyncKind("none") == .unsynchronized)
        #expect(MXLParser.parseSyncKind("tempo") == .tempo)
    }

    @Test
    func parseVirtualInstrumentDataContent_ensemble() throws {
        let content = try MXLParser.parseVirtualInstrumentDataContent(node("<ensemble>8</ensemble>"))

        #expect(content == .ensemble(8))
    }
}
