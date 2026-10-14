cask "git-worktree-tracker" do
  version "0.1.0"
  sha256 "1c81495e4e72a8eecf8914d812761d1421ea88dbe17508acb3fb0128779f5d5d"

  url "https://github.com/duynguyentho/git-worktree-tracker/releases/download/v#{version}/Worktrees-#{version}.zip"
  name "Worktrees"
  desc "Track, inspect and safely clean up git worktrees across repos"
  homepage "https://github.com/duynguyentho/git-worktree-tracker"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Worktrees.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper refuses to open the app.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Worktrees.app"]
  end

  uninstall quit: "io.github.duynguyentho.git-worktree-tracker"

  zap trash: [
    "~/.config/git-worktree-tracker",
    "~/Library/Application Support/git-worktree-tracker",
    "~/Library/Caches/git-worktree-tracker",
    "~/Library/Preferences/io.github.duynguyentho.git-worktree-tracker.plist",
  ]

  caveats <<~EOS
    Worktrees needs git and Python 3 from the Xcode Command Line Tools:
      xcode-select --install
    PR status needs the GitHub CLI: brew install gh
  EOS
end
