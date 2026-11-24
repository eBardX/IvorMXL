// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLNormalizerChangeTests {
}

// MARK: -

extension MXLNormalizerChangeTests {
    @Test
    func equality() {
        #expect(MXLNormalizer.Change.renamedElement("a", "b") == .renamedElement("a", "b"))
        #expect(MXLNormalizer.Change.renamedElement("a", "b") != .replacedConstruct("a", "b"))
    }

    @Test
    func message_isNotEmpty() {
        let allCases: [MXLNormalizer.Change] = [.convertedToPartwise,
                                                .renamedElement("old", "new"),
                                                .replacedConstruct("old", "new"),
                                                .suppliedDefault("divisions", "1"),
                                                .upgradedVersion(.v1_0, .v4_0)]

        for change in allCases {
            #expect(!change.message.isEmpty)
        }
    }

    @Test
    func message_quotesTheAssociatedValues() {
        #expect(MXLNormalizer.Change.renamedElement("directive", "other").message.contains("‘directive’"))
        #expect(MXLNormalizer.Change.suppliedDefault("divisions", "1").message.contains("‘1’"))
    }

    @Test
    func message_spellsVersionsInDottedForm() {
        let message = MXLNormalizer.Change.upgradedVersion(.v1_0, .v4_0).message

        #expect(message.contains("1.0"))
        #expect(message.contains("4.0"))
    }
}
