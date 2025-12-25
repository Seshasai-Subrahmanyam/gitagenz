# 🕉️ Code Dharma

> **Ancient wisdom for the modern coder**

A beautiful Flutter application that bridges the timeless teachings of the Bhagavad Gita with modern software engineering principles. Experience shlokas (verses) in Sanskrit with English and Telugu translations, along with insightful applications to the software industry.

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-success)
![License](https://img.shields.io/badge/License-MIT-blue)

---

## ✨ Features

- 📜 **Sanskrit Shlokas** — Authentic verses rendered in Devanagari script with Tiro Devanagari Sanskrit font
- 🌐 **Multi-Language Translations** — English and Telugu translations for each verse
- 💻 **Software Industry Insights** — Modern interpretations connecting ancient wisdom to software engineering
- 🎬 **Immersive Video Background** — Cinematic landing page with looping video banner
- 🌓 **Light & Dark Mode** — Automatic theme switching based on system preferences
- 📱 **Responsive Design** — Optimized layouts for mobile, tablet, and desktop
- ✨ **Smooth Animations** — Parallax scrolling, staggered list animations, and comic-style buttons
- 🔮 **Glassmorphic UI** — Beautiful frosted-glass app bar with backdrop blur

---

## 🖼️ Screenshots

| Landing Page | Shloka Viewer |
|:------------:|:-------------:|
| Video background with call-to-action | Sanskrit text with translations |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.8.1 or later)
- Android Studio / VS Code with Flutter extension
- An emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/gitagenz.git
   cd gitagenz
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For mobile
   flutter run
   
   # For web
   flutter run -d chrome
   ```

---

## 📁 Project Structure

```
gitagenz/
├── lib/
│   ├── main.dart              # Main application with all widgets
│   └── app_constants.dart     # Centralized app configuration
├── assets/
│   ├── data/
│   │   └── bhagavad_gita_data.json  # Shloka content database
│   └── images/
│       ├── banner.mp4         # Landing page video background
│       └── shloka*.png        # Shloka illustrations
├── android/                   # Android-specific configuration
├── ios/                       # iOS-specific configuration
├── web/                       # Web-specific configuration
└── pubspec.yaml               # Project dependencies
```

---

## 🎨 Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **google_fonts** | Custom typography (Lato, Bangers, Tiro Devanagari) |
| **video_player** | Video background playback |

---

## 📖 Content Structure

Each shloka in the JSON data includes:

```json
{
  "sanskrit": "Original Sanskrit verse",
  "english_translation": "English meaning",
  "telugu_translation": "Telugu translation",
  "illustration": "Path to illustration image",
  "software_explanation": "Modern software industry context",
  "key_lesson": "Core takeaway for developers",
  "modern_application": "Practical application in tech"
}
```

---

## 🛠️ Customization

### Adding New Shlokas

1. Add illustration images to `assets/images/`
2. Update `assets/data/bhagavad_gita_data.json` with new shloka data
3. Register new assets in `pubspec.yaml`

### Theming

Modify `lib/app_constants.dart` to customize:
- Primary colors
- Font sizes for different screen sizes
- Layout breakpoints

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- The timeless wisdom of the **Bhagavad Gita**
- Flutter team for the amazing framework
- Google Fonts for beautiful typography

---

<p align="center">
  Made with ❤️ and 🕉️
</p>
