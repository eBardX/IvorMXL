// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserDirectionTests {
}

// MARK: -

extension MXLParserDirectionTests {
    @Test
    func parseAccordionMiddle_validAndInvalid() {
        #expect(MXLParser.parseAccordionMiddle("2")?.uintValue == 2)
        #expect(MXLParser.parseAccordionMiddle("4") == nil)
    }

    @Test
    func parseAccordionRegistration() throws {
        let registration = try MXLParser.parseAccordionRegistration(node(#"""
            <accordion-registration><accordion-high/><accordion-middle>2</accordion-middle></accordion-registration>
            """#))

        #expect(registration.hasHighDot)
        #expect(registration.accordionMiddle?.uintValue == 2)
        #expect(!registration.hasLowDot)
    }

    @Test
    func parseBracket() throws {
        let bracket = try MXLParser.parseBracket(node(#"<bracket type="start" number="2" line-end="down" line-type="dashed"/>"#))

        #expect(bracket.kind == .start)
        #expect(bracket.number?.uintValue == 2)
        #expect(bracket.lineEnd == .down)
        #expect(bracket.lineKind == .dashed)
    }

    @Test
    func parseBracket_missingLineEndThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseBracket(node(#"<bracket type="stop"/>"#))
        }
    }

    @Test
    func parseDirection() throws {
        let direction = try MXLParser.parseDirection(node(#"""
            <direction placement="above" directive="yes"><direction-type><words>Allegro</words></direction-type>
            <staff>1</staff></direction>
            """#))

        #expect(direction.placement == .above)
        #expect(direction.isDirective == true)
        #expect(direction.kind.count == 1)
        #expect(direction.staff?.uintValue == 1)
    }

    @Test
    func parseDirectionKindContent_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseDirectionKindContent(node(#"<pitch/>"#))
        }
    }

    @Test
    func parseDynamics() throws {
        let dynamics = try MXLParser.parseDynamics(node(#"<dynamics placement="below"><p/><sfz/></dynamics>"#))

        #expect(dynamics.items == [.p, .sfz])
        #expect(dynamics.placement == .below)
    }
}
