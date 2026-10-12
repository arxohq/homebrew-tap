# Формула Homebrew для tap arxohq/homebrew-tap (DECISION-0384 §4, канал cli-brew).
# Байты — те же архивы GitHub Release, что у @arxo/cli и install.sh; sha256
# каждого архива подставляет джоба build-cli-release.yml при выпуске.
# Файл в этом репозитории — образец и источник для tap; сам tap — отдельный
# репозиторий, куда джоба кладёт готовую формулу.
class Law < Formula
  desc "Arxo Law: execute a pinned canon — cases, packages, questions with proof"
  homepage "https://www.arxo.io"
  version "0.2.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/arxohq/law-releases/releases/download/law-v#{version}/law-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "fe556747a5e2a3f9d2e6f09ea5740ba3a88c5c81166f57bc4708f55054fa6a59"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arxohq/law-releases/releases/download/law-v#{version}/law-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50c2f2882458d136fcf9c0fdeeaa92bc801ac1b713e35a22ec7e365149106419"
    end
  end

  def install
    bin.install "law"
    bin.install "law-lsp" if File.exist?("law-lsp")
    (share/"arxo").install "law-dist-manifest.json"
    prefix.install "LICENSE", "NOTICE", "THIRD-PARTY-NOTICES.txt"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/law version")
  end
end
