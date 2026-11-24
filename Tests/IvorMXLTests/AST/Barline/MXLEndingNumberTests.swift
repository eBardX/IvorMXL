// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLEndingNumberTests {
}

// MARK: -

extension MXLEndingNumberTests {
    @Test
    func parseEndingNumber_empty() {
        #expect(MXLParser.parseEndingNumber(" ")?.isEmpty == true)
    }

    @Test
    func parseEndingNumber_list() {
        #expect(MXLParser.parseEndingNumber("1, 2") == [1, 2])
    }

    @Test
    func parseEndingNumber_nonNumericItem() {
        #expect(MXLParser.parseEndingNumber("1, two") == nil)
    }

    @Test
    func writeEnding_joinsNumber() {
        let ending = MXLEnding(value: "",
                               number: [1, 2],
                               kind: .start)
        let written = writtenNode { $0.writeEnding(ending) }

        #expect(written.attributes?[.number] == "1,2")
    }
}
