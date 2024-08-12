import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:your_friend/Theme/theme_model.dart';

class Geminiscreen extends StatefulWidget {
  const Geminiscreen({super.key});

  @override
  State<Geminiscreen> createState() => _GeminiscreenState();
}

class _GeminiscreenState extends State<Geminiscreen> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  List<ChatUser> typing = [];

  // Two users of this App Ai 0 & User 1
  // User
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "Sharjeel",
    profileImage: "assets/Images/robo.png",
  );

  // Ai
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: 'Your Friend',
    profileImage: "assets/Images/robo.png",
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeNotifier, child) {
        // Define colors for light and dark modes
        Color backgroundColor =
            themeNotifier.isDark ? Colors.black : Colors.white;
        Color userBubbleColor =
            themeNotifier.isDark ? Colors.white70 : Colors.purple;
        Color aiBubbleColor =
            themeNotifier.isDark ? Colors.white70 : Colors.grey[100]!;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              decoration: BoxDecoration(
                color:
                    themeNotifier.isDark ? Colors.grey[900] : Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: AppBar(
                backgroundColor:
                    themeNotifier.isDark ? Colors.grey[900] : Colors.grey[300],
                elevation: 1,
                title: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Your Friend',
                        textStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        speed: const Duration(seconds: 3),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
                leading: const Padding(
                  padding: EdgeInsets.all(7.0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white70,
                    backgroundImage: AssetImage('assets/Images/robo.png'),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(themeNotifier.isDark
                        ? Icons.wb_sunny
                        : Icons.nightlight_round),
                    onPressed: () {
                      themeNotifier.isDark =
                          !themeNotifier.isDark; // Toggle theme
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: backgroundColor,
          body: Column(
            children: [
              Expanded(
                child: DashChat(
                  currentUser: currentUser,
                  onSend: _sendMessage,
                  messages: messages,
                  messageOptions: MessageOptions(
                    currentUserContainerColor: userBubbleColor,
                    containerColor: aiBubbleColor,
                  ),
                ),
              ),
              if (typing.isNotEmpty) ...[
                TypingIndicator(), // Typing indicator widget
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          // AI ka profile image
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage('assets/Images/robo.png'),
          ),
          const SizedBox(width: 10),
          // Typing bubble
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "AI is typing...",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Typing indicator dots
                  SizedBox(
                    height: 10,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText('.',
                            duration: const Duration(milliseconds: 500)),
                        FadeAnimatedText('..',
                            duration: const Duration(milliseconds: 500)),
                        FadeAnimatedText('...',
                            duration: const Duration(milliseconds: 500)),
                      ],
                      isRepeatingAnimation: true,
                      pause: const Duration(
                          milliseconds: 500), // Pause between animations
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
      typing.clear(); // Clear typing indicator when message is sent
    });
    try {
      String question = chatMessage.text;
      setState(() {
        typing.add(geminiUser); // Show typing indicator
      });
      gemini.streamGenerateContent(question).listen((event) {
        setState(() {
          typing.clear(); // Hide typing indicator
        });
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                "",
                (previous, current) => "$previous ${current.text}",
              ) ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                "",
                (previous, current) => "$previous ${current.text}",
              ) ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
