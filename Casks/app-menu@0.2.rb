cask "app-menu@0.2" do
  version "0.2"
  sha256 "7bcb7bdfec79d9f958fdc2364db26ad52f07c33d8bd743efd0379a3f2c9caac7"

  url "https://github.com/barseghyanartur/app-menu/releases/download/0.2/ApplicationMenu.zip"
  name "App Menu"
  desc "The missing Applications Menu for macOS."
  homepage "https://github.com/barseghyanartur/app-menu"

  container type: :naked

  stage_only true

  postflight do
    zip_path = "#{staged_path}/ApplicationMenu.zip"
    extract_dir = "#{staged_path}/extracted"

    system_command "unzip", args: ["-d", extract_dir, zip_path]

    dmg_path = "#{extract_dir}/ApplicationMenu.dmg"

    if File.exist?(dmg_path)
      system_command "hdiutil",
                     args: ["attach", "-nobrowse", dmg_path]

      if File.exist?("/Applications/ApplicationMenu.app")
        system_command "rm", args: ["-rf", "/Applications/ApplicationMenu.app"]
      end

      system_command "cp", 
                     args: ["-r", "/Volumes/ApplicationMenu/ApplicationMenu.app", "/Applications/"]

      system_command "hdiutil",
                     args: ["detach", "/Volumes/ApplicationMenu"]
    else
      raise "DMG file not found: #{dmg_path}"
    end
  end

  uninstall delete: "/Applications/ApplicationMenu.app"
end
