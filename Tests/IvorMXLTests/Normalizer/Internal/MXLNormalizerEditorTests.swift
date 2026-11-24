// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLNormalizerEditorTests {
}

// MARK: -

extension MXLNormalizerEditorTests {
    @Test
    func edit_currentScoreIsUnchanged() throws {
        let document = try parse("minimal-partwise.musicxml")

        let (edited, changes) = MXLNormalizer.Editor(document: document).edit()

        #expect(changes.isEmpty)
        #expect(edited.content == document.content)
        #expect(edited.isNormalized)
    }

    @Test
    func edit_oldOpusIsUpgraded() {
        let opus = MXLOpus(version: .v1_1,
                           title: "Old",
                           items: [])
        let document = MXLDocument(content: .opus(opus))

        let (edited, changes) = MXLNormalizer.Editor(document: document).edit()

        #expect(changes == [.upgradedVersion(.v1_1, .current)])
        guard case let .opus(upgraded) = edited.content
        else { Issue.record("expected an opus"); return }

        #expect(upgraded.version == .current)
    }

    @Test
    func edit_preservesIsValidatedWithoutChanges() throws {
        let source = try parse("minimal-partwise.musicxml")
        let document = MXLDocument(content: source.content,
                                   isNormalized: false,
                                   isValidated: true)

        let (edited, _) = MXLNormalizer.Editor(document: document).edit()

        #expect(edited.isValidated)
    }

    @Test
    func edit_timewiseIsConvertedFirst() throws {
        let document = try parse("minimal-timewise.musicxml")

        let (edited, changes) = MXLNormalizer.Editor(document: document).edit()

        #expect(changes.first == .convertedToPartwise)
        guard case .scorePartwise = edited.content
        else { Issue.record("expected a part-wise score"); return }
    }
}
