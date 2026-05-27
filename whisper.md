

16:35
Yes. The same whisper.cpp setup works — you just swap the model file. You want:

whisper-small is actually multilingual by default — the -en suffix means English-only. So you've been using the English-only variant. The multilingual equivalent is just small (no -en).

Download it the same way you got the English one:

bash
cd ~/screens/tech/linux_setup/whisper.cpp
bash models/download-ggml-model.sh small
That gives you models/ggml-small.bin, which supports Traditional Chinese. Then in your dictate.sh, change the model flag from small.en to small.

Better option for Chinese specifically: medium

Whisper's Chinese accuracy jumps noticeably from small→medium because Chinese has more tonal/character ambiguity than English. If your hardware can handle it, medium (the multilingual version, not medium.en) is worth trying. Still a drop-in swap.

Traditional vs Simplified: Whisper tends to output Simplified by default even for Taiwan Mandarin input. To get Traditional, pass the language and prompt flags:

bash
whisper-cli --language zh --prompt "以下是台灣繁體中文。" -m models/ggml-small.bin ...
The prompt nudges the output toward Traditional characters. It's not perfect but helps significantly.

What is the hardware issue?

16:36
Whisper models are slow on CPU. The sizes roughly are:

Model	Size	Relative speed (CPU)
tiny	75MB	very fast
base	142MB	fast
small	466MB	moderate
medium	1.5GB	slow
large	3GB	very slow
Your XPS 15 has a decent CPU so small is probably fine in real time, but medium might feel sluggish for dictation where you want low latency turnaround.

whisper.cpp does support GPU acceleration (CUDA, Metal, OpenCL) but on Linux with an Nvidia GPU you'd need to compile with CUDA support — if you didn't do that originally it's running pure CPU. Worth checking whether your XPS 15 build has CUDA enabled:

bash
~/screens/tech/linux_setup/whisper.cpp/whisper-cli --help 2>&1 | grep -i cuda
If CUDA is compiled in and your GPU is available, medium becomes very practical.

