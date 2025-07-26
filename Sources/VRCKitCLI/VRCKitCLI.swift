import ArgumentParser
import VRCKit

@main
struct VRC: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift-based command-line tool for VRChat.",
        subcommands: [Login.self]
    )
}
