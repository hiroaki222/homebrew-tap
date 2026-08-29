class Koe < Formula
  desc "Speaker-attributed transcripts and minutes for Japanese meetings"
  homepage "https://github.com/hiroaki222/koe"
  license any_of: ["MIT", "Apache-2.0"]

  # ffmpeg and ffprobe are shelled out to rather than linked, and are the one
  # dependency a package manager is better at than a download. The Whisper model
  # is not one: it is 1.5 GB and versions independently of this tool.
  depends_on "ffmpeg"

  # Metal and CoreML carry the transcription and the diarization. An Intel Mac
  # has neither path, so it is refused here rather than after the download.
  on_macos do
    on_arm do
      url "https://github.com/hiroaki222/koe/releases/download/v0.1.0/koe-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "7e31dfb4e13fdea6af899aa1844f272d28c5af0dd9c16fdeae70a223cecd180c"
    end
  end

  def install
    bin.install "koe"
  end

  def caveats
    <<~EOS
      koe needs a Whisper model, which is not bundled:

        mkdir -p ~/.koe/models
        curl -L -o ~/.koe/models/ggml-large-v3-turbo.bin \\
          https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo.bin
        export KOE_WHISPER_MODEL=~/.koe/models/ggml-large-v3-turbo.bin

      Minutes are optional. To generate them, install llama.cpp, fetch a GGUF
      that handles Japanese well, and point KOE_LLM_MODEL at it:

        brew install llama.cpp
        export KOE_LLM_MODEL=/path/to/model.gguf
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/koe --version")

    # No model is present in the test sandbox, so the run cannot reach whisper.
    # What can be asserted is that it says so rather than failing some other way.
    output = shell_output("KOE_WHISPER_MODEL=#{testpath}/absent.bin #{bin}/koe #{testpath}/x.mp4 2>&1", 1)
    assert_match "whisper model not found", output
  end
end
