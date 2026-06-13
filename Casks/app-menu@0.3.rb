cask "app-menu@0.3" do
  version "0.3"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/barseghyanartur/app-menu/releases/download/0.3/ApplicationMenu.dmg"
  name "App Menu"
  desc "The missing Applications Menu for macOS"
  homepage "https://github.com/barseghyanartur/app-menu"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "ApplicationMenu.app"
end
