import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// شريط إدخال المحادثة: إرفاق صورة / إرسال موقع / تسجيل صوت / نص / إرسال.
class ChatInputBar extends StatefulWidget {
  final ValueChanged<String> onSendText;
  final VoidCallback onAttachImage;
  final VoidCallback onSendLocation;
  final void Function(String path, int durationMs) onSendVoice;

  const ChatInputBar({
    super.key,
    required this.onSendText,
    required this.onAttachImage,
    required this.onSendLocation,
    required this.onSendVoice,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  final _recorder = AudioRecorder();
  bool _hasText = false;
  bool _recording = false;
  final _stopwatch = Stopwatch();
  Timer? _ticker;
  Duration _elapsed = Duration.zero;

  @override
  void dispose() {
    _ticker?.cancel();
    _controller.dispose();
    _recorder.dispose();
    super.dispose();
  }

  void _sendText() {
    if (_controller.text.trim().isEmpty) return;
    widget.onSendText(_controller.text);
    _controller.clear();
    setState(() => _hasText = false);
  }

  Future<void> _startRecording() async {
    if (!await _recorder.hasPermission()) return;
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);
    _stopwatch
      ..reset()
      ..start();
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (mounted) setState(() => _elapsed = _stopwatch.elapsed);
    });
    setState(() => _recording = true);
  }

  Future<void> _stopAndSend() async {
    final ms = _stopwatch.elapsedMilliseconds;
    final path = await _recorder.stop();
    _cleanupRecording();
    if (path != null && ms > 500) {
      widget.onSendVoice(path, ms);
    }
  }

  Future<void> _cancelRecording() async {
    await _recorder.cancel();
    _cleanupRecording();
  }

  void _cleanupRecording() {
    _ticker?.cancel();
    _stopwatch.stop();
    if (mounted) {
      setState(() {
        _recording = false;
        _elapsed = Duration.zero;
      });
    }
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: _recording ? _recordingRow() : _normalRow(),
      ),
    );
  }

  Widget _normalRow() {
    return Row(
      children: [
        _iconBtn(Icons.camera_alt_rounded, widget.onAttachImage),
        _iconBtn(Icons.location_on_rounded, widget.onSendLocation),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty),
              onSubmitted: (_) => _sendText(),
              textInputAction: TextInputAction.send,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalRegular,
              ),
              decoration: InputDecoration(
                hintText: LocaleKeys.typeMessage.tr(),
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _hasText ? _sendText : _startRecording,
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _hasText ? Icons.send_rounded : Icons.mic_rounded,
              color: Colors.white,
              size: 20.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _recordingRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: _cancelRecording,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Icon(Icons.delete_outline_rounded,
                color: AppColors.error, size: 26.w),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                _PulsingDot(),
                SizedBox(width: 10.w),
                Text(
                  _fmt(_elapsed),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  LocaleKeys.recording.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: _stopAndSend,
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.send_rounded, color: Colors.white, size: 20.w),
          ),
        ),
      ],
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Icon(icon, color: AppColors.navy, size: 24.w),
    ),
  );
}

/// نقطة حمراء نابضة أثناء التسجيل.
class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.3, end: 1.0).animate(_c),
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: const BoxDecoration(
          color: AppColors.error,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
