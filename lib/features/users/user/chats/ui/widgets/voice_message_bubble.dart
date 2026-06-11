import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import '../../data/models/message_model.dart';

/// فقاعة رسالة صوتية: تشغيل/إيقاف + موجة صوتية + المدّة.
class VoiceMessageBubble extends StatefulWidget {
  final MessageModel message;
  final bool me;
  const VoiceMessageBubble({super.key, required this.message, required this.me});

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  final PlayerController _controller = PlayerController();
  StreamSubscription<PlayerState>? _stateSub;
  bool _prepared = false;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _prepare();
    _stateSub = _controller.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _playing = state.isPlaying);
    });
  }

  Future<void> _prepare() async {
    final path = widget.message.voicePath;
    if (path == null) return;
    try {
      await _controller.preparePlayer(path: path, noOfSamples: 48);
      await _controller.setFinishMode(finishMode: FinishMode.pause);
      if (mounted) setState(() => _prepared = true);
    } catch (_) {
      // تعذّر تجهيز الملف — يُعرض الزر بدون موجة.
    }
  }

  @override
  void dispose() {
    _stateSub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (!_prepared) return;
    if (_playing) {
      await _controller.pausePlayer();
    } else {
      await _controller.startPlayer();
    }
  }

  String _fmt(int ms) {
    final d = Duration(milliseconds: ms);
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final fg = widget.me ? Colors.white : AppColors.orange;
    return SizedBox(
      width: 210.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _toggle,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: widget.me
                    ? Colors.white.withValues(alpha: 0.22)
                    : AppColors.softOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: fg,
                size: 22.w,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.h,
                  child: _prepared
                      ? AudioFileWaveforms(
                          size: Size(140.w, 30.h),
                          playerController: _controller,
                          enableSeekGesture: true,
                          waveformType: WaveformType.fitWidth,
                          playerWaveStyle: PlayerWaveStyle(
                            fixedWaveColor: widget.me
                                ? Colors.white54
                                : AppColors.border,
                            liveWaveColor: fg,
                            waveThickness: 2.5,
                            spacing: 4.w,
                          ),
                        )
                      : Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            height: 3.h,
                            width: 130.w,
                            color: widget.me ? Colors.white54 : AppColors.border,
                          ),
                        ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.mic_rounded, size: 13.w, color: fg),
                    SizedBox(width: 4.w),
                    Text(
                      _fmt(widget.message.voiceMs ?? 0),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: widget.me
                            ? Colors.white70
                            : AppColors.secondaryText,
                        fontFamily: FontFamily.tajawalRegular,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
