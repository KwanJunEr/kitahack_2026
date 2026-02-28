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

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: "Good morning! 🌞 The sunlight feels amazing on my leaves right now.",
      isPlant: true,
      time: '08:15 AM',
    ),
    _ChatMessage(
      text: "I'm feeling a bit thirsty today! Could you check my soil? 💧",
      isPlant: true,
      time: '10:30 AM',
    ),
    _ChatMessage(
      text: "Of course! Just gave you a nice drink and some fertilizer. 🚀",
      isPlant: false,
      time: '10:35 AM',
    ),
    _ChatMessage(
      text: "Thanks for the fertilizer! I feel more spicy already! 🌶️✨",
      isPlant: true,
      time: '10:36 AM',
    ),
  ];

  final List<String> _quickReplies = [
    "How's the humidity?",
    "Need more sun?",
    "Pruning tips?",
    "Fertilizer schedule?",
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(
        text: text.trim(),
        isPlant: false,
        time: _currentTime(),
      ));
    });
    _inputController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate plant response
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add(_ChatMessage(
          text: _plantResponse(text.trim()),
          isPlant: true,
          time: _currentTime(),
        ));
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
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
    if (lower.contains('humidity')) {
      return "The humidity feels just right today! Around 60% is my sweet spot 🌿";
    } else if (lower.contains('sun')) {
      return "I love basking in the morning sun! About 6 hours a day keeps me happy ☀️";
    } else if (lower.contains('prun')) {
      return "Yes! Trim my lower leaves when they yellow. It helps me grow stronger! ✂️";
    } else if (lower.contains('water')) {
      return "Thank you for the water! I was getting a little dry 💧";
    } else if (lower.contains('fertilizer')) {
      return "I'd love some balanced NPK fertilizer every 2 weeks 🌱✨";
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
    return Column(
      children: [
        /// Plant header card
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.05),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFDDEBEA),
                  border: Border.all(
                      color: const Color(0xFF0F6D6A), width: 2),
                ),
                child: const Icon(Icons.eco,
                    color: Color(0xFF0F6D6A), size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0F4F4D),
                    ),
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                          radius: 4, backgroundColor: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'ONLINE • PLANT',
                        style: TextStyle(
                          color: Color(0xFF0F6D6A),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.info_outline,
                  color: Color(0xFF0F6D6A), size: 22),
            ],
          ),
        ),

        /// Chat messages
        Expanded(
          child: Container(
            color: const Color(0xFFF4F7F6),
            child: ListView.builder(
              controller: _scrollController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const _DateChip(label: 'TODAY');
                }
                final msg = _messages[index - 1];
                return _ChatBubble(message: msg);
              },
            ),
          ),
        ),

        /// Quick replies
        Container(
          color: Colors.white,
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _quickReplies
                  .map((r) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => _sendMessage(r),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF0F6D6A)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              r,
                              style: const TextStyle(
                                color: Color(0xFF0F6D6A),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),

        /// Input bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: Color(0xFF0F6D6A)),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  controller: _inputController,
                  onSubmitted: _sendMessage,
                  decoration: InputDecoration(
                    hintText: 'Ask your plant something...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFEBF4F3),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _sendMessage(_inputController.text),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F6D6A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),

        /// Footer
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 12),
          child: const Center(
            child: Text(
              'Eco-Friendly Assistant • Powered by NatureAI',
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ),
        ),
      ],
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
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
            letterSpacing: 0.5,
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
    if (message.isPlant) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDDEBEA),
              ),
              child: const Icon(Icons.eco,
                  color: Color(0xFF0F6D6A), size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.62,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.05),
                      )
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF0F4F4D)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style:
                      const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.62,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F6D6A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style:
                      const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0F6D6A),
              ),
              child: const Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}