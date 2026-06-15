cask "app-menu@0.3" do
  version "0.3"
  sha256 "9162be3405fb6880746a742d72c0559dcfc338e8f0805af960c09f873915be91"

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
