cask "app-menu@0.1.3" do
  version "0.1.3"
  sha256 "94641df16db661a2e59ba856d3eb293aa05dcc14a373d45ab3ac5c6bd3602f76"

  url "https://github.com/barseghyanartur/app-menu/files/15419363/ApplicationMenu.zip"
  name "App Menu"
  desc "The missing Applications Menu for macOS."
  homepage "https://github.com/barseghyanartur/app-menu"

  container type: :naked

  stage_only true

  postflight do
    zip_path = "#{staged_path}/ApplicationMenu.zip"
    extract_dir = "#{staged_path}/extracted"

    # Unzip the downloaded file
    system_command "unzip", args: ["-d", extract_dir, zip_path]

    dmg_path = "#{extract_dir}/ApplicationMenu.dmg"

    if File.exist?(dmg_path)
      # Mount the dmg file
      system_command "hdiutil",
                     args: ["attach", "-nobrowse", dmg_path]

      # Delete any existing application to force-replace
      if File.exist?("/Applications/ApplicationMenu.app")
        system_command "rm", args: ["-rf", "/Applications/ApplicationMenu.app"]
      end

      # Copy the new application to /Applications
      system_command "cp", 
                     args: ["-r", "/Volumes/ApplicationMenu/ApplicationMenu.app", "/Applications/"]

      # Unmount the dmg file
      system_command "hdiutil",
                     args: ["detach", "/Volumes/ApplicationMenu"]
    else
      raise "DMG file not found: #{dmg_path}"
    end
  end

  uninstall delete: "/Applications/ApplicationMenu.app"
end
