import 'package:debate_app/core/theme/color.dart';
import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:debate_app/features/Debate/presentation/widgets/chat_bubble_widget.dart';
import 'package:debate_app/features/Debate/presentation/widgets/message_input_widget.dart';
import 'package:debate_app/features/Debate/presentation/widgets/typing_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatPage extends StatefulWidget {
  final String topic;
  final String role; // Pro/Kontra

  const ChatPage({super.key, required this.topic, required this.role});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  late SpeechToText _speechToText;
  late FlutterTts _flutterTts;
  bool _speechEnabled = false;
  bool _isUserStopped = true;

  int _lastItemCount = 0;

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
    _flutterTts = FlutterTts();
    _initTextToSpeech();
    _initSpeech();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    _flutterTts.stop();
    _speechToText.stop();
    super.dispose();
  }

  // Text To Speech
  Future<void> _initTextToSpeech() async {
    await _flutterTts.setLanguage("id-ID");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0); // Volume 2.0 mungkin terlalu tinggi, 1.0 adalah maksimal normal
  }

  void _speak(String text) async {
    await _flutterTts.stop(); // Hentikan suara sebelumnya sebelum memulai yang baru
    await _flutterTts.speak(text);
  }

  void _stop() async {
    await _flutterTts.stop();
  }

  // Speech To Text
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (!_speechEnabled) return;
    _stop(); // MODIFIKASI: Hentikan TTS jika sedang berbicara saat user mulai merekam suara
    setState(() => _isUserStopped = false);
    _textCtrl.clear();
    await _speechToText.listen(
      pauseFor: const Duration(minutes: 10),
      localeId: 'id_ID',
      onResult: _onSpeechResult,
    );
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isUserStopped = true);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
        _textCtrl.text = result.recognizedWords;
        _textCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: _textCtrl.text.length),
      );
    });
  }

  void _handleSend() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;

    _stop(); // MODIFIKASI: Hentikan suara AI jika user mengirim pesan
    final bloc = context.read<DebateBloc>();
    if (bloc.currentSessionId == 0) {
      bloc.add(
        CreateSessionEvent(
          prompt: text,
          topic: widget.topic,
          role: widget.role,
        ),
      );
    } else {
      bloc.add(SendMessageEvent(text));
    }
    _textCtrl.clear();
    // Setelah mengirim, pastikan speech-to-text berhenti jika masih aktif
    if (!_isUserStopped) {
      _stopListening();
    }
  }

  void _scrollToBottom({bool animated = true}) {
    if (!_scrollCtrl.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final offset = _scrollCtrl.position.maxScrollExtent;
      if (animated) {
        _scrollCtrl.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollCtrl.jumpTo(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const Text("Debate Room", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () async {
            // MODIFIKASI: Hentikan semua audio sebelum keluar dari halaman
            _stop();
            await _speechToText.stop();

            FocusScope.of(context).unfocus();
            await Future<void>.delayed(const Duration(milliseconds: 20));
            if (context.mounted) Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<DebateBloc, DebateState>(
              listener: (context, state) {
                // MODIFIKASI: Logika untuk memutar suara dipindahkan ke sini
                // Ini hanya akan berjalan sekali ketika state berubah ke DebatLoaded
                if (state is DebatLoaded) {
                  final lastMessage = context.read<DebateBloc>().messages.lastOrNull;
                  // Jika ada pesan terakhir dan itu dari asisten (AI)
                  if (lastMessage != null && lastMessage.role == 'assistant') {
                    _speak(lastMessage.content);
                  }
                }
                
                // Logika untuk auto-scroll
                final bloc = context.read<DebateBloc>();
                final hasTyping = state is DebateLoading;
                final currentCount = bloc.messages.length + (hasTyping ? 1 : 0);
                final increased = currentCount > _lastItemCount;
                _lastItemCount = currentCount;

                if (increased) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                final bloc = context.read<DebateBloc>();
                final isTyping = state is DebateLoading;
                final items = List<ChatEntity>.from(bloc.messages);

                if (isTyping) {
                  items.add(
                    ChatEntity(
                      role: 'assistant',
                      content: '__typing__',
                      sessionId: bloc.currentSessionId,
                    ),
                  );
                }

                if (state is DebateError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is DebatLoaded || state is DebateLoading || bloc.messages.isNotEmpty) {
                  return ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final m = items[i];
                      if (m.content == '__typing__') {
                        return const TypingBubble();
                      }
                      
                      // DIHAPUS: Logika _speak() dan _stop() yang tadinya ada di sini, dihapus.
                      // Blok if yang sebelumnya ada di sini adalah sumber masalah.

                      return ChatBubbleWidget(message: m);
                    },
                  );
                }
                
                // Initial state
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          MessageInputWidget(
            textController: _textCtrl,
            sendMessage: _handleSend,
            isListening: !_isUserStopped,
            onMicPressed: _isUserStopped ? _startListening : _stopListening,
          ),
        ],
      ),
    );
  }
}