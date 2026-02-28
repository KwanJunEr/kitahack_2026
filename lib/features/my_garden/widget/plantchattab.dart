import 'package:flutter/material.dart';

class PlantDetailTabChat extends StatefulWidget {
  final String name;

  const PlantDetailTabChat({super.key, required this.name});

  @override
  State<PlantDetailTabChat> createState() => _PlantDetailTabChatState();
}

class _PlantDetailTabChatState extends State<PlantDetailTabChat> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [];
  bool _isPlantTyping = false;

  final List<_ChatMessage> _initialConversation = const [
    _ChatMessage(
      text: "I'm feeling a bit thirsty today! Could you check my soil? 💧 Very sad now",
      isPlant: true,
      time: '10:30 AM',
    ),
  ];

  final List<String> _quickReplies = const [
    "How's the humidity?",
    "Need more sun?",
    "Pruning tips?",
    "Fertilizer schedule?",
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  Future<void> _loadInitialMessages() async {
    for (var msg in _initialConversation) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() => _messages.add(msg));
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          text: text.trim(),
          isPlant: false,
          time: _currentTime(),
        ),
      );
      _isPlantTyping = true;
    });

    _inputController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      final response = _plantResponse(text.trim());

      setState(() {
        _isPlantTyping = false;
        _messages.add(
          _ChatMessage(
            text: response,
            isPlant: true,
            time: _currentTime(),
          ),
        );
      });

      _scrollToBottom();
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _plantResponse(String input) {
    final lower = input.toLowerCase();

    if (lower.contains('drink') ||
        lower.contains('water') ||
        lower.contains('fertilizer')) {
      return "Thanks for the water! I feel more better already! 🌶️✨";
    }

    if (lower.contains('humidity')) {
      return "The humidity feels just right today! Around 60% is my sweet spot 🌿";
    }

    if (lower.contains('sun')) {
      return "I love basking in the morning sun! About 6 hours a day keeps me happy ☀️";
    }

    if (lower.contains('prun')) {
      return "Yes! Trim my lower leaves when they yellow. It helps me grow stronger! ✂️";
    }

    return "Thanks for checking in on me! I'm growing strong today 🌱";
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalItems =
        1 + _messages.length + (_isPlantTyping ? 1 : 0); // date + messages + typing

    return Column(
      children: [
        _Header(name: widget.name),

        Expanded(
          child: Container(
            color: const Color(0xFFF4F7F6),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: totalItems,
              itemBuilder: (context, index) {
                /// Date chip
                if (index == 0) return const _DateChip(label: 'TODAY');

                /// Messages
                final messageIndex = index - 1;

                if (messageIndex < _messages.length) {
                  return _ChatBubble(message: _messages[messageIndex]);
                }

                /// Typing indicator
                return const _TypingIndicator();
              },
            ),
          ),
        ),

        _QuickReplies(replies: _quickReplies, onTap: _sendMessage),
        _InputBar(controller: _inputController, onSend: _sendMessage),
      ],
    );
  }
}

/// ================= UI =================

class _Header extends StatelessWidget {
  final String name;
  const _Header({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFDDEBEA),
            child: Icon(Icons.eco, color: Color(0xFF0F6D6A)),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF0F4F4D),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFDDEBEA),
            child: Icon(Icons.eco, color: Color(0xFF0F6D6A), size: 18),
          ),
          SizedBox(width: 10),
          Text(
            "Plant is typing...",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _QuickReplies extends StatelessWidget {
  final List<String> replies;
  final Function(String) onTap;

  const _QuickReplies({required this.replies, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: replies
              .map(
                (r) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => onTap(r),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF0F6D6A)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        r,
                        style: const TextStyle(
                            color: Color(0xFF0F6D6A), fontSize: 13),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const _InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSend,
              decoration: InputDecoration(
                hintText: 'Ask your plant something...',
                filled: true,
                fillColor: const Color(0xFFEBF4F3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => onSend(controller.text),
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFF0F6D6A),
              child: Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isPlant;
  final String time;

  const _ChatMessage({
    required this.text,
    required this.isPlant,
    required this.time,
  });
}

class _DateChip extends StatelessWidget {
  final String label;
  const _DateChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.62;

    if (message.isPlant) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFDDEBEA),
              child: Icon(Icons.eco, color: Color(0xFF0F6D6A), size: 18),
            ),
            const SizedBox(width: 10),
            Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(message.text),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F6D6A),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}