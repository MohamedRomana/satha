import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import '../../data/models/message_model.dart';

/// فقاعة رسالة صوتية: تشغيل/إيقاف + شريط تقدّم + المدّة.
class VoiceMessageBubble extends StatefulWidget {
  final MessageModel message;
  final bool me;
  const VoiceMessageBubble({super.key, required this.message, required this.me});

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  final _player = AudioPlayer();
  bool _playing = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;

  @override
  void initState() {
    super.initState();
    _total = Duration(milliseconds: widget.message.voiceMs ?? 0);
    _player.onDurationChanged.listen((d) {
      if (mounted && d > Duration.zero) setState(() => _total = d);
    });
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _playing = false;
          _position = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    final path = widget.message.voicePath;
    if (path == null) return;
    if (_playing) {
      await _player.pause();
      if (mounted) setState(() => _playing = false);
    } else {
      await _player.play(DeviceFileSource(path));
      if (mounted) setState(() => _playing = true);
    }
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final fg = widget.me ? Colors.white : AppColors.orange;
    final track = widget.me
        ? Colors.white.withValues(alpha: 0.4)
        : AppColors.border;
    final progress = _total.inMilliseconds == 0
        ? 0.0
        : (_position.inMilliseconds / _total.inMilliseconds).clamp(0.0, 1.0);
    return SizedBox(
      width: 200.w,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: progress == 0 ? null : progress,
                    minHeight: 4.h,
                    backgroundColor: track,
                    valueColor: AlwaysStoppedAnimation(fg),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.mic_rounded, size: 13.w, color: fg),
                    SizedBox(width: 4.w),
                    Text(
                      _playing || _position > Duration.zero
                          ? _fmt(_position)
                          : _fmt(_total),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: widget.me ? Colors.white70 : AppColors.secondaryText,
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
