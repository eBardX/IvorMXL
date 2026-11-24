// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiTools

struct MXLFormatterErrorTests {
}

// MARK: -

extension MXLFormatterErrorTests {
    @Test
    func cause_isNilExceptForWriteFailure() {
        #expect(MXLFormatter.Error.notValidated.cause == nil)
        #expect(MXLFormatter.Error.unsupportedTimewise.cause == nil)
        #expect(MXLFormatter.Error.writeFailure(nil).cause == nil)
    }

    @Test
    func message_isNotEmpty() {
        let allCases: [MXLFormatter.Error] = [.notValidated,
                                              .unsupportedTimewise,
                                              .writeFailure(nil)]

        for error in allCases {
            #expect(!error.message.isEmpty)
            #expect(error.category == Category("IvorMXL"))
        }
    }

    @Test
    func message_namesTheRemedy() {
        #expect(MXLFormatter.Error.notValidated.message.contains("MXLValidator.validate(_:)"))
        #expect(MXLFormatter.Error.unsupportedTimewise.message.contains("normalized"))
    }
}
