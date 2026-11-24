// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserMusicItemTests {
}

// MARK: -

extension MXLParserMusicItemTests {
    @Test
    func parseBackup() throws {
        let backup = try MXLParser.parseBackup(node("<backup><duration>8</duration></backup>"))

        #expect(backup.duration.intValue == 8)
    }

    @Test
    func parseBackup_missingDurationThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseBackup(node(#"<backup/>"#))
        }
    }

    @Test
    func parseForward() throws {
        let forward = try MXLParser.parseForward(node("<forward><duration>4</duration><voice>2</voice><staff>1</staff></forward>"))

        #expect(forward.duration.intValue == 4)
        #expect(forward.voice?.voice == "2")
        #expect(forward.staff?.uintValue == 1)
    }

    @Test
    func parseGrouping() throws {
        let grouping = try MXLParser.parseGrouping(node(#"""
            <grouping type="start" number="2" member-of="g1"><feature type="phrase">A</feature></grouping>
            """#))

        #expect(grouping.kind == .start)
        #expect(grouping.number == "2")
        #expect(grouping.memberOf == "g1")
        #expect(grouping.feature == [MXLFeature(value: "A",
                                                kind: "phrase")])
    }

    @Test
    func parseLevel() throws {
        let level = try MXLParser.parseLevel(node(#"<level reference="yes" type="single" parentheses="yes">ed.</level>"#))

        #expect(level.value == "ed.")
        #expect(level.isReferenceOnly == true)
        #expect(level.kind == .single)
        #expect(level.display.hasParentheses == true)
    }

    @Test
    func parseMusicItem_dispatchesOnElement() throws {
        let item = try MXLParser.parseMusicItem(node("<backup><duration>1</duration></backup>"))

        guard case .backup = item
        else { Issue.record("expected a backup item"); return }
    }

    @Test
    func parseMusicItem_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseMusicItem(node(#"<pitch/>"#))
        }
    }

    @Test
    func parseStaffNumber_validAndInvalid() {
        #expect(MXLParser.parseStaffNumber("2")?.uintValue == 2)
        #expect(MXLParser.parseStaffNumber("0") == nil)
    }
}
