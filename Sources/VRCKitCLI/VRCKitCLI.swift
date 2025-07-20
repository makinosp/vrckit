import ArgumentParser
import VRCKit

@main
struct VRC: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift-based command-line tool for VRChat.",
        subcommands: [Login.self]
    )
}

struct Login: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "login",
        abstract: "Login to VRChat."
    )

    @Option(name: .shortAndLong, help: "Your VRChat username.")
    var username: String

    @Option(name: .shortAndLong, help: "Your VRChat password.")
    var password: String

    func run() async throws {
        let client = APIClient()
        let credential = Credential(username: username, password: password)
        await client.setCredentials(credential)
        let authService = AuthenticationService(client: client)

        do {
            let result = try await authService.loginUserInfo()
            switch result {
            case .left(let user):
                print("Login successful!")
                print("ID: \(user.id)")
                print("Display Name: \(user.displayName)")
            case .right(let verifyType):
                print("Two-factor authentication required: \(verifyType.rawValue)")
            }
        } catch {
            print("Login failed: \(error.localizedDescription)")
        }
    }
}
