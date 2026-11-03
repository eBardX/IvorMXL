# IvorMXL

A MusicXML parser, normalizer, validator, and formatter.

[![Swift 6.3](https://img.shields.io/badge/Swift-6.3-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/eBardX/IvorMXL/blob/main/LICENSE.md)

* [Overview](#overview)
* [Requirements](#requirements)
* [Installation](#installation)
    * [Swift Package Manager](#spm_installation)
* [Quick Start](#quick_start)
* [Documentation](#documentation)
* [Reference Documentation](#reference_documentation)
* [Credits](#credits)
* [License](#license)

## <a name="overview">Overview</a>

The IvorMXL framework provides a [MusicXML][musicxml] parser, normalizer,
validator, and formatter written in Swift. It targets [MusicXML 4.0][mxlspec],
reading every earlier version back to 1.0, with a strict-concurrency-ready,
value-type API. Both compressed (`.mxl`) and uncompressed MusicXML files are
supported.

IvorMXL's syntactic core turns MusicXML bytes into a typed, round-trippable
abstract syntax tree (`MXLDocument` → `MXLScorePartwise` →
`MXLScorePartwise.Part` → `MXLMusicItem`) and back to bytes, without
interpreting the music.

Everything flows through a small, explicit pipeline of four value types, each
with a no-argument initializer:

 Stage     | Type            | Input → Output
:-----     |:----            |:--------------
 Parse     | `MXLParser`     | `Data` → `MXLDocument`
 Normalize | `MXLNormalizer` | `MXLDocument` → `MXLDocument` (current version)
 Validate  | `MXLValidator`  | `MXLDocument` → validated `MXLDocument`
 Format    | `MXLFormatter`  | `MXLDocument` → `Data`

The pipeline is gated by two flags on `MXLDocument`: a document must be
normalized before it can be validated, and validated before it can be
formatted. `MXLDocument.Content` has one case per document element a MusicXML
root file may have — a part-wise score, a time-wise score, or an `<opus>`. All
three parse, normalize, and validate; the formatter writes part-wise scores and
opus documents (a time-wise score is normalized to part-wise first). See the
[usage guide][guide] for a full walkthrough of the API.

## <a name="requirements">Requirements</a>

* iOS 18.0+ / macOS 15.0+
* Swift 6.3 toolchain
* Swift 6 language mode

## <a name="installation">Installation</a>

### <a name="spm_installation">Swift Package Manager</a>

IvorMXL is distributed exclusively through the [Swift Package Manager][spm].

To add IvorMXL to a Swift package, add it to the `dependencies` in your
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/eBardX/IvorMXL.git",
             .upToNextMinor(from: "0.1.0"))
]
```

Then add `IvorMXL` to the dependencies of any target that uses it:

```swift
.target(name: "MyTarget",
        dependencies: [.product(name: "IvorMXL",
                                package: "IvorMXL")])
```

To add IvorMXL to an Xcode project, choose **File ▸ Add Package Dependencies…**
and enter the repository URL:

```
https://github.com/eBardX/IvorMXL.git
```

IvorMXL depends on [XestiArchive][xestiarchive], [XestiTools][xestitools], and
[XestiXML][xestixml]; the Swift Package Manager resolves them automatically.

## <a name="quick_start">Quick Start</a>

Take a MusicXML file from `Data` through the full pipeline and back to `Data`:

```swift
import Foundation
import IvorMXL

let data = try Data(contentsOf: url)

// 1. Parse MusicXML bytes into a typed AST.
let (parsed, diagnostics) = try MXLParser().parse(data, compressed: false)

// 2. Normalize the document to the most recent supported MusicXML version.
let (normalized, changes) = MXLNormalizer().normalize(parsed)

// 3. Validate — e.g. every `<part>` id names a declared `<score-part>`.
let (validated, issues) = try MXLValidator().validate(normalized)

guard issues.isEmpty
else { issues.forEach { print($0.message) }; return }

// 4. Format back to MusicXML bytes.
let output = try MXLFormatter().format(validated, compressed: false)
```

Each stage is independent, so you can stop at the AST or round-trip through
the formatter. For the complete story — the AST model and error handling — see
the [usage guide][guide].

## <a name="documentation">Documentation</a>

* [Using IvorMXL][guide] — a guide to using the public API, published as part
  of the DocC documentation.
* Every public declaration carries a DocC comment.

## <a name="reference_documentation">Reference Documentation</a>

Full [reference documentation][refdoc] is available courtesy of [DocC][docc].

## <a name="credits">Credits</a>

John Gary Pusey (ebardx@gmail.com)

## <a name="license">License</a>

IvorMXL is available under [the MIT license][license].

[docc]:          https://www.swift.org/documentation/docc/
[guide]:         https://eBardX.github.io/ivor-packages-docs/documentation/ivormxl/usingivormxl
[license]:       https://github.com/eBardX/IvorMXL/blob/main/LICENSE.md
[musicxml]:      https://www.musicxml.com
[mxlspec]:       https://www.w3.org/2021/06/musicxml40/
[refdoc]:        https://eBardX.github.io/ivor-packages-docs/documentation/ivormxl
[spm]:           https://swift.org/package-manager/
[xestiarchive]:  https://github.com/eBardX/XestiArchive
[xestitools]:    https://github.com/eBardX/XestiTools
[xestixml]:      https://github.com/eBardX/XestiXML
