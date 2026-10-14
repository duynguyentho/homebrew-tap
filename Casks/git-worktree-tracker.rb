cask "git-worktree-tracker" do
  version "0.2.0"
  sha256 "617c85770dd2435a5a8202083167e08bb669d6be5ed724b00ac252b4a5eb27c3"

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
