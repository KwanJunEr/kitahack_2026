# KitaHack 2026 — Team Kaki Code

> **FuturaGrow** — A hyper-AI-driven urban micro-farming ecosystem powered by AR and gamification, transforming shared spaces into sustainable urban farms to address Malaysia's food security crisis.

---

## 👥 Team Members

| Name | Role |
|------|------|
| Jonas Kwan | Team Lead / Developer |
| Tsang Da Xin | Developer |
| Tan Wai Ken | Developer |
| Lucius Wilbert | Developer |

---

## 🌱 About FuturaGrow

Malaysia's food import bill reached a record **RM93.8 billion in 2024**. Urban B40 households spend up to **70% of their income on food**, while **70% of urban dwellers** lack the knowledge and space to grow their own produce.

FuturaGrow is a mobile application that combines **Gemini AI**, **AR visualization**, and **community-driven resource sharing** to empower urban households — particularly B40 families — to grow food in high-density living environments like apartments and PPR housing.

### 🎯 UN SDG Alignment
- **SDG 2** — Zero Hunger
- **SDG 3** — Good Health and Well-being
- **SDG 11** — Sustainable Cities and Communities

---

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🤖 AI Plant Companion | Gemini-powered conversational companion with long-context memory for personalised care guidance |
| 🔍 AR Space Analyzer | ARCore-powered tool to visualise plant placement and receive AI suitability scores, ROI projections, and harvest timelines |
| 🌿 Plant Health Monitoring | Daily AI image analysis of plant diaries to detect disease and pest issues proactively |
| 📅 Autonomous Care Scheduling | Gemini ADK schedules plant care tasks directly into Google Calendar via MCP |
| 🗺️ Neighbor Map & Community | Google Maps-powered community to discover nearby urban farmers and exchange seeds, tools, and produce |
| 📊 Yield & Fertilizer AI | TensorFlow models deployed on Vertex AI for precise fertilizer recommendations and yield predictions |
| ♻️ AI Sustainability Checker | Analyses farming practices and food waste images to generate composting and improvement recommendations |

---

## 🏗️ Technical Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Flutter Mobile App                     │
│              (Android Studio IDE + Emulator)             │
└────────────────────────┬────────────────────────────────┘
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
┌─────────────┐  ┌──────────────┐  ┌──────────────────────┐
│  Firebase   │  │  Google AI   │  │   Google Services    │
│             │  │  Tech Stack  │  │                      │
│  • Auth     │  │  • Gemini AI │  │  • Google Maps       │
│  • Firestore│  │  • ADK       │  │  • Google Calendar   │
└─────────────┘  │  • TensorFlow│  │    (via MCP)         │
                 │  • Vertex AI │  │  • ARCore            │
                 │  • Nano      │  └──────────────────────┘
                 │    Banana    │
                 └──────────────┘
```

---

## 🛠️ Google Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform mobile development framework |
| **Android Studio** | IDE and emulator environment |
| **Firebase Authentication** | Secure email & password auth with session management |
| **Cloud Firestore** | Real-time NoSQL database for all app data |
| **Gemini AI + ADK** | AI plant companion, health analysis, agentic scheduling |
| **TensorFlow + Vertex AI** | Custom ML models for fertilizer, nutrient, and yield predictions |
| **Google Maps** | Location-based community discovery and Neighbor Map |
| **Google Calendar (MCP)** | Autonomous plant care scheduling by Gemini AI agent |
| **ARCore** | AR spatial mapping for the Digital Twin Space Analyzer |
| **Nano Banana** | Image generation for visual platform features |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Android Studio
- Android SDK (API level 24+)
- A physical or virtual Android device with ARCore support
- Google Firebase project configured
- Google Cloud project with Vertex AI and Gemini API enabled

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/kitahack_2026.git
cd kitahack_2026

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Firebase Setup

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Authentication** (Email/Password)
3. Enable **Cloud Firestore**
4. Download `google-services.json` and place it in `/android/app/`

### Environment Configuration

Create a `.env` file in the project root:

```env
GEMINI_API_KEY=your_gemini_api_key
GOOGLE_MAPS_API_KEY=your_maps_api_key
VERTEX_AI_PROJECT_ID=your_project_id
VERTEX_AI_LOCATION=your_location
```

---

## 📊 Impact Metrics

| Metric | Target |
|--------|--------|
| 🌾 National Food Resilience | 30–50% increase in local fresh vegetable availability; 15–25% reduction in household food spending |
| ✅ Grower Success Rate | 50–70% improvement in novice microfarmer harvest success rates |
| 🤝 Circular Economy & Community | 30–50% increase in community well-being and social connectedness |

---

## 🗺️ Implementation Roadmap

```
Q1–Q2 2026  ──▶  MVP: Core app, Firebase, Gemini companion, AR Analyzer, Community Map
Q3–Q4 2026  ──▶  AI Intelligence: TensorFlow models, Sustainability Checker, Points & Rewards
Q1–Q2 2027  ──▶  Ecosystem: 100+ crop database, RAG with Gemini, Mentor matching
Q3 2027–    ──▶  National Scale: Penang, JB, KK, Kuching + Government partnerships
Q1 2028
```

---

## 🏆 Competitive Advantage

| Feature | FuturaGrow | PlantSnap | Gardyn | Planta |
|---------|:----------:|:---------:|:------:|:------:|
| Plant Identification | ✅ | ✅ | ❌ | ✅ |
| Care Reminders | ✅ | ❌ | ✅ | ✅ |
| AR Space Visualization | ✅ | ❌ | ❌ | ❌ |
| Optimal Location AI | ✅ | ❌ | ❌ | ❌ |
| Malaysia Tropical Crops | ✅ | ❌ | ❌ | ❌ |
| Community Marketplace | ✅ | ❌ | ❌ | ❌ |
| Yield Prediction AI | ✅ | ❌ | ❌ | ❌ |

---

## 📁 Project Structure

```
kitahack_2026/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── welcome_screen.dart
│   │   ├── garden_screen.dart
│   │   ├── ar_analyzer_screen.dart
│   │   ├── community_screen.dart
│   │   └── sustainability_screen.dart
│   ├── services/
│   │   ├── gemini_service.dart
│   │   ├── firestore_service.dart
│   │   ├── vertex_ai_service.dart
│   │   └── maps_service.dart
│   ├── models/
│   │   ├── plant_model.dart
│   │   ├── user_model.dart
│   │   └── diary_model.dart
│   └── widgets/
├── android/
│   └── app/
│       └── google-services.json
├── assets/
│   ├── images/
│   └── crop_database/
└── pubspec.yaml
```

---



---

## 📄 License

This project was built for KitaHack 2026. All rights reserved by Team Kaki Code.

---

<div align="center">
  <strong>Built with ❤️ for Malaysia's urban farming community</strong><br/>
  <em>Team Kaki Code — KitaHack 2026</em>
</div>
