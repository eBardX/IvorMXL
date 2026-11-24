// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLModeTests {
}

// MARK: -

extension MXLModeTests {
    @Test
    func parseKeyContent_absentMode() throws {
        let content = try MXLParser.parseKeyContent(node("<key><fifths>0</fifths></key>"))

        guard case let .traditionalKey(key) = content
        else { Issue.record("expected a traditional key"); return }

        #expect(key.mode == nil)
    }

    @Test
    func parseKeyContent_keepsModeVerbatim() throws {
        let content = try MXLParser.parseKeyContent(node("<key><fifths>-3</fifths><mode>dorian</mode></key>"))

        guard case let .traditionalKey(key) = content
        else { Issue.record("expected a traditional key"); return }

        #expect(key.mode == "dorian")
    }
}
