# homebrew-tap

Homebrew formulae for tools published from this account.

```sh
brew tap hiroaki222/tap
```

## transcrate

```sh
brew install hiroaki222/tap/transcrate
```

The command line tool from
[transcrate](https://github.com/hiroaki222/transcrate): it reads audio files
and answers whether Pioneer DJ and AlphaTheta players will accept them, and
converts the ones they will not.

ffmpeg comes with it as a dependency, which is what the tool needs and does not
carry. The desktop app is a separate download and brings its own.

Apple silicon and x86-64 Linux. Intel Macs are not built for.

## koe

```sh
brew install hiroaki222/tap/koe
```

Speaker-attributed transcripts and minutes from Japanese meeting recordings,
from [koe](https://github.com/hiroaki222/koe). Everything runs locally: no audio
or text leaves the machine.

ffmpeg comes with it. The Whisper model does not, at 1.5 GB, and the language
model that writes the minutes is optional; `brew install` prints how to fetch
both.

Apple silicon only. Transcription runs on Metal and diarization on CoreML.
