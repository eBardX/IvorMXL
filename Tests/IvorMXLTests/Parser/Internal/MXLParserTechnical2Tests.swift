// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserTechnical2Tests {
}

// MARK: -

extension MXLParserTechnical2Tests {
    @Test
    func parseHoleClosedLocation_invalidValue() {
        #expect(MXLParser.parseHoleClosedLocation("bogus") == nil)
    }

    @Test
    func parseHoleClosedLocation_validValues() {
        #expect(MXLParser.parseHoleClosedLocation("bottom") == .bottom)
        #expect(MXLParser.parseHoleClosedLocation("left") == .left)
        #expect(MXLParser.parseHoleClosedLocation("right") == .right)
        #expect(MXLParser.parseHoleClosedLocation("top") == .top)
    }

    @Test
    func parseHoleClosedValue_invalidValue() {
        #expect(MXLParser.parseHoleClosedValue("bogus") == nil)
    }

    @Test
    func parseHoleClosedValue_validValues() {
        #expect(MXLParser.parseHoleClosedValue("half") == .half)
        #expect(MXLParser.parseHoleClosedValue("no") == .no)
        #expect(MXLParser.parseHoleClosedValue("yes") == .yes)
    }

    @Test
    func parseRelease() throws {
        let release = try MXLParser.parseRelease(node(#"<release offset="3"/>"#))

        #expect(release.offset?.intValue == 3)
    }

    @Test
    func parseStringMute_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseStringMute(node(#"<string-mute/>"#))
        }
    }

    @Test
    func parseTapHand_invalidValue() {
        #expect(MXLParser.parseTapHand("bogus") == nil)
    }

    @Test
    func parseTapHand_validValues() {
        #expect(MXLParser.parseTapHand("left") == .left)
        #expect(MXLParser.parseTapHand("right") == .right)
    }

    @Test
    func parseTechnical() throws {
        let technical = try MXLParser.parseTechnical(node(#"""
            <technical><up-bow/><fingering substitution="yes">3</fingering><string>2</string><fret>5</fret>
            <hammer-on type="start" number="1">H</hammer-on><bend shape="curved"><bend-alter>1</bend-alter>
            <release offset="2"/><with-bar>scoop</with-bar></bend><harmonic><artificial/><touching-pitch/></harmonic>
            <tap hand="left">T</tap><other-technical smufl="handbellsDamp3">d</other-technical></technical>
            """#))

        #expect(technical.items.count == 9)
    }

    @Test
    func parseTechnicalItem_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseTechnicalItem(node(#"<pitch/>"#))
        }
    }

    @Test
    func parseTipDirection_invalidValue() {
        #expect(MXLParser.parseTipDirection("bogus") == nil)
    }

    @Test
    func parseTipDirection_validValues() {
        #expect(MXLParser.parseTipDirection("down") == .down)
        #expect(MXLParser.parseTipDirection("left") == .left)
        #expect(MXLParser.parseTipDirection("northeast") == .northeast)
        #expect(MXLParser.parseTipDirection("northwest") == .northwest)
        #expect(MXLParser.parseTipDirection("right") == .right)
        #expect(MXLParser.parseTipDirection("southeast") == .southeast)
        #expect(MXLParser.parseTipDirection("southwest") == .southwest)
        #expect(MXLParser.parseTipDirection("up") == .up)
    }
}
