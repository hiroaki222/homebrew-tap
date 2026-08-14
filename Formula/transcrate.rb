class Transcrate < Formula
  desc "Convert tracks for a USB stick and know they will play on CDJs and XDJs"
  homepage "https://github.com/hiroaki222/transcrate"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  # The command line tool expects an ffmpeg it did not bring, which is the one
  # thing a package manager is better at than a download. The desktop app is
  # the build that carries its own.
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/hiroaki222/transcrate/releases/download/v0.3.0/transcrate-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "081a42d126033a4e821572c35a8a7041f842f7e25b4c96898e6b485507822d81"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/hiroaki222/transcrate/releases/download/v0.3.0/transcrate-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "95d1d4e08659e399c20008d35297ad5af947ef5e1af6398eac9512c5dac12212"
    end
  end

  def install
    bin.install "transcrate"
    generate_completions_from_executable(bin/"transcrate", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/transcrate --version")

    # Reads a real file rather than only answering --version: what this package
    # is for is the verdict, and the verdict needs ffprobe to have come along.
    system "ffmpeg", "-hide_banner", "-loglevel", "error", "-y",
           "-f", "lavfi", "-i", "sine=frequency=440:duration=1",
           "-c:a", "pcm_s16le", testpath/"tone.wav"
    assert_match "WAV", shell_output("#{bin}/transcrate check #{testpath}/tone.wav")
  end
end
