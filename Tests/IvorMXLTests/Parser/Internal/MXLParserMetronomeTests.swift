// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserMetronomeTests {
}

// MARK: -

extension MXLParserMetronomeTests {
    @Test
    func parseBeatUnit() throws {
        let beatUnit = try MXLParser.parseBeatUnit(node("<metronome><beat-unit>half</beat-unit><beat-unit-dot/><beat-unit-dot/></metronome>"))

        #expect(beatUnit.beatUnit == .half)
        #expect(beatUnit.dot == 2)
    }

    @Test
    func parseBeatUnit_missingBeatUnitThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseBeatUnit(node(#"<metronome><beat-unit-dot/></metronome>"#))
        }
    }

    @Test
    func parseMetronome_beatUnitEquation() throws {
        let metronome = try MXLParser.parseMetronome(node(#"""
            <metronome><beat-unit>half</beat-unit><beat-unit>quarter</beat-unit><beat-unit-dot/></metronome>
            """#))

        guard case let .beatUnit(beatUnit, _, content) = metronome.content,
              case let .beatUnit(secondBeatUnit, _) = content
        else { Issue.record("expected a beat-unit equation"); return }

        #expect(beatUnit.beatUnit == .half)
        #expect(secondBeatUnit.beatUnit == .quarter)

        // The dots are read by element name rather than by position, so the
        // first beat unit takes every `<beat-unit-dot>` and the second none.
        withKnownIssue("beat-unit-dot elements are not assigned to the beat unit they follow") {
            #expect(beatUnit.dot == 0)
            #expect(secondBeatUnit.dot == 1)
        }
    }

    @Test
    func parseMetronome_metronomeNotesSplitAtRelation() throws {
        let metronome = try MXLParser.parseMetronome(node(#"""
            <metronome><metronome-note><metronome-type>quarter</metronome-type></metronome-note>
            <metronome-relation>equals</metronome-relation><metronome-note><metronome-type>half</metronome-type>
            </metronome-note></metronome>
            """#))

        guard case let .metronomeArrows(_, note, relation, secondNote) = metronome.content
        else { Issue.record("expected metronome-note content"); return }

        #expect(relation == "equals")

        // Both lists are read by element name, so each gets every
        // `<metronome-note>` instead of the ones on its side of the relation.
        withKnownIssue("metronome-note elements are not split at the metronome-relation") {
            #expect(note.map(\.kind) == [.quarter])
            #expect(secondNote.map(\.kind) == [.half])
        }
    }

    @Test
    func parseMetronome_perMinute() throws {
        let metronome = try MXLParser.parseMetronome(node(#"""
            <metronome parentheses="yes" justify="left"><beat-unit>quarter</beat-unit><beat-unit-dot/>
            <per-minute font-size="10">c. 72</per-minute></metronome>
            """#))

        guard case let .beatUnit(beatUnit, _, .perMinute(perMinute)) = metronome.content
        else { Issue.record("expected beat-unit content"); return }

        #expect(beatUnit.beatUnit == .quarter)
        #expect(perMinute.value == "c. 72")
        #expect(metronome.hasParentheses == true)
    }

    @Test
    func parseMetronomeNoteTied_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseMetronomeNoteTied(node(#"<metronome-tied/>"#))
        }
    }
}
