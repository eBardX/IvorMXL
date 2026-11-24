// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLValidatorIssueTests {
}

// MARK: -

extension MXLValidatorIssueTests {
    @Test
    func equality() {
        #expect(MXLValidator.Issue.danglingPartID("P1") == .danglingPartID("P1"))
        #expect(MXLValidator.Issue.danglingPartID("P1") != .unusedScorePart("P1"))
    }

    @Test
    func message_includesAssociatedValues() {
        let message = MXLValidator.Issue.unmatchedEndingStop(number: 2,
                                                             part: "P3",
                                                             measure: "17").message

        #expect(message.contains("P3"))
        #expect(message.contains("17"))
        #expect(message.contains("2"))
    }

    @Test
    func message_isNeverEmpty() {
        let allCases: [MXLValidator.Issue] = [.danglingPartID("P1"),
                                              .durationBeforeDivisions(part: "P1", measure: "1"),
                                              .unbalancedPartGroup(number: "1"),
                                              .unknownInstrumentSound("keyboard.pianoforte"),
                                              .unmatchedEndingStart(number: 1, part: "P1", measure: "1"),
                                              .unmatchedEndingStop(number: 1, part: "P1", measure: "1"),
                                              .unusedScorePart("P1")]

        for issue in allCases {
            #expect(!issue.message.isEmpty)
        }
    }
}
