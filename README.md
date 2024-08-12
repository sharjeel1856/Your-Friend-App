# Your Friend - Flutter Chat Application

## Overview

"Your Friend" is a Flutter-based chat application that integrates with the Gemini API to provide an interactive chat experience. The app includes features such as theme toggling, splash screens, introductory pages, and a chat interface with typing indicators. 

## Features

- **Splash Screen**: Animated splash screen with a loading animation.
- **Intro Screens**: Multiple introductory screens with page indicators and navigation.
- **Theme Management**: Light and dark mode supported with persistent theme settings.
- **Chat Interface**: Chat functionality with animated text and typing indicators.
- **Integration with Gemini API**: Real-time AI chat responses.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- An IDE such as Visual Studio Code or Android Studio

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/your-project-name.git
   cd your-project-name
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Set Up Gemini API Key**

   Create a file named `key.dart` in the `lib` directory and add your Gemini API key:

   ```dart
   const String GEMINI_API_KEY = 'your_api_key_here';
   ```

4. **Run the Application**

   ```bash
   flutter run
   ```

## Project Structure

- **lib/**: Contains the main Dart files.
  - **main.dart**: Entry point of the application.
  - **Theme/**: Contains theme management classes (`theme_model.dart`, `theme_prefernces.dart`).
  - **SplashScreen/**: Contains the splash screen widget (`splash_screen.dart`).
  - **IntroScreens/**: Contains introductory screens (`HomeScreenA.dart`, `HomeScreenB.dart`, `HomeScreenC.dart`).
  - **GeminiScreen/**: Contains the chat interface (`Geminiscreen.dart`).

- **assets/**: Contains images and animations used in the app.
  - **Images/**: Image assets.
  - **animations/**: Lottie animation files.

## Usage

- **Toggling Theme**: Click the icon button in the AppBar to switch between light and dark themes.
- **Navigating Intro Screens**: Use "Skip" or "Next" buttons to navigate through introductory pages.
- **Chat**: Send messages and receive responses from the AI. Typing indicator is shown when the AI is generating a response.

## Contributing

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/) - Framework for building the application.
- [Gemini API](https://www.gemini.com/) - AI chatbot integration.
- [Lottie](https://pub.dev/packages/lottie) - Animation package used in the splash screen.
