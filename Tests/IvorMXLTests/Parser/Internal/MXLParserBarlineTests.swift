// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserBarlineTests {
}

// MARK: -

extension MXLParserBarlineTests {
    @Test
    func parseBarline() throws {
        let barline = try MXLParser.parseBarline(node(#"""
            <barline location="left" segno="s1"><bar-style>heavy-light</bar-style><repeat direction="forward" times="2"/>
            </barline>
            """#))

        #expect(barline.location == .left)
        #expect(barline.barStyle?.value == .heavyLight)
        #expect(barline.repeat?.direction == .forward)
        #expect(barline.repeat?.times == 2)
        #expect(barline.segnoAttribute == "s1")
    }

    @Test
    func parseBarlineStyleColorStyle_invalidValue() {
        #expect(MXLParser.parseBarlineStyleColorStyle("bogus") == nil)
    }

    @Test
    func parseBarlineStyleColorStyle_validValues() {
        #expect(MXLParser.parseBarlineStyleColorStyle("dashed") == .dashed)
        #expect(MXLParser.parseBarlineStyleColorStyle("dotted") == .dotted)
        #expect(MXLParser.parseBarlineStyleColorStyle("heavy") == .heavy)
        #expect(MXLParser.parseBarlineStyleColorStyle("heavy-heavy") == .heavyHeavy)
        #expect(MXLParser.parseBarlineStyleColorStyle("heavy-light") == .heavyLight)
        #expect(MXLParser.parseBarlineStyleColorStyle("light-heavy") == .lightHeavy)
        #expect(MXLParser.parseBarlineStyleColorStyle("light-light") == .lightLight)
        #expect(MXLParser.parseBarlineStyleColorStyle("none") == .invisible)
        #expect(MXLParser.parseBarlineStyleColorStyle("regular") == .regular)
        #expect(MXLParser.parseBarlineStyleColorStyle("short") == .short)
        #expect(MXLParser.parseBarlineStyleColorStyle("tick") == .tick)
    }

    @Test
    func parseEnding() throws {
        let ending = try MXLParser.parseEnding(node(#"<ending number="1, 2" type="discontinue" end-length="30">1., 2.</ending>"#))

        #expect(ending.value == "1., 2.")
        #expect(ending.number == [1, 2])
        #expect(ending.kind == .discontinue)
        #expect(ending.endLength == 30)
    }

    @Test
    func parseEnding_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseEnding(node(#"<ending number="1"/>"#))
        }
    }

    @Test
    func parseRepeat_missingDirectionThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseRepeat(node(#"<repeat times="2"/>"#))
        }
    }

    @Test
    func parseRepeatDirection_invalidValue() {
        #expect(MXLParser.parseRepeatDirection("bogus") == nil)
    }

    @Test
    func parseRepeatDirection_validValues() {
        #expect(MXLParser.parseRepeatDirection("backward") == .backward)
        #expect(MXLParser.parseRepeatDirection("forward") == .forward)
    }
}
