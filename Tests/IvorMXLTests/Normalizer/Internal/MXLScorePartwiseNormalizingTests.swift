// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLScorePartwiseNormalizingTests {
}

// MARK: -

extension MXLScorePartwiseNormalizingTests {
    @Test
    func mappingMusicItems_identityPreservesScore() throws {
        let score = try partwise("minimal-partwise.musicxml")

        #expect(score.mappingMusicItems { $0 } == score)
    }

    @Test
    func mappingMusicItems_transformsEveryItem() throws {
        let score = try partwise("minimal-partwise.musicxml")
        let backup = try MXLMusicItem.backup(MXLBackup(duration: #require(MXLPositiveDivisions(intValue: 1))))

        let mapped = score.mappingMusicItems { _ in backup }

        #expect(mapped.parts.flatMap(\.measures).flatMap(\.items).allSatisfy { $0 == backup })
        #expect(mapped.parts.map(\.id) == score.parts.map(\.id))
    }

    @Test
    func mappingPartListItems_identityPreservesScore() throws {
        let score = try partwise("minimal-partwise.musicxml")

        #expect(score.mappingPartListItems { $0 } == score)
    }

    @Test
    func withVersion_changesOnlyTheVersion() throws {
        let score = try partwise("minimal-partwise.musicxml")

        let stamped = score.withVersion(.v2_0)

        #expect(stamped.version == .v2_0)
        #expect(stamped.withVersion(score.version) == score)
    }
}
