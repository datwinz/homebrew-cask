cask "claude" do
  version "0.7.5,2251fe73a7dbc3127ad9f1cad762150d13dd4393"
  sha256 "84784df5f10c773a98681cf08a8013858c86c55a0a4988329d8cd9e6e9574d7c"

  url "https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest/release-#{version.csv.first}-artifact-#{version.csv.second}.zip",
      verified: "storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest/"
  name "Claude"
  desc "Anthropic's official Claude AI desktop app"
  homepage "https://claude.ai/download"

  livecheck do
    url "https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest/update_manifest.json"
    regex(/release[._-]v?(\d+(?:\.\d+)+)[._-]artifact[._-](\h+)\.zip/i)
    strategy :json do |json, regex|
      json["releases"]&.map do |item|
        match = item.dig("updateTo", "url")&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Claude.app"

  zap trash: [
    "~/Library/Application Support/Claude",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.anthropic.claudefordesktop.sfl*",
    "~/Library/Caches/com.anthropic.claudefordesktop",
    "~/Library/Caches/com.anthropic.claudefordesktop.ShipIt",
    "~/Library/HTTPStorages/com.anthropic.claudefordesktop",
    "~/Library/Preferences/com.anthropic.claudefordesktop.plist",
    "~/Library/Saved Application State/com.anthropic.claudefordesktop.savedState",
  ]
end
