{
  pkgs,
  inputs,
  ...
}: {
  # quill — meeting recorder + transcriber (github.com/bindusara-reddy/quill-linux).
  # Linux twin of digimata/quill: PipeWire captures mic + system audio as two
  # tracks, Parakeet TDT 0.6B v3 transcribes locally (model auto-downloads to
  # ~/.cache/quill on first use), transcript lands speaker-tagged (me/them) in
  # ~/Recordings and the audio is deleted. `quill` toggles recording; also in
  # the launcher as "Quill".
  #
  # The vulkan variant auto-picks the RTX 3060 over the iGPU — a 5-minute
  # meeting transcribes in ~20 s (vs ~3 min on CPU). QUILL_CPU=1 falls back.
  home.packages = [
    inputs.quill-linux.packages.${pkgs.stdenv.hostPlatform.system}.vulkan
  ];
}
