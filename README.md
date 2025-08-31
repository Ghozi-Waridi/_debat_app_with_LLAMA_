# Debate App with LLM Integration

Aplikasi debat interaktif berbasis Flutter dengan integrasi AI (Large Language Model) dan backend Django untuk platform diskusi dan debat yang cerdas.

## 📱 Deskripsi

Debate App adalah aplikasi mobile yang memungkinkan pengguna untuk melakukan debat interaktif dengan dukungan AI. Aplikasi ini dilengkapi dengan fitur speech-to-text, text-to-speech, dan backend yang kuat untuk mengelola sesi debat dan topik diskusi.

## ✨ Fitur Utama

- 🎯 **Manajemen Topik Debat** - Kelola dan pilih topik debat yang menarik
- 🎤 **Speech-to-Text (STT)** - Konversi suara menjadi teks secara real-time
- 🔊 **Text-to-Speech (TTS)** - Konversi teks menjadi suara
- 🤖 **Integrasi AI/LLM** - Chat dan analisis debat dengan kecerdasan buatan
- 💬 **API Chat** - Komunikasi real-time dengan backend
- 📱 **Multi-platform** - Support Android, iOS, Web, dan Desktop
- 🎨 **UI Modern** - Antarmuka pengguna yang responsif dan intuitif

## 🛠️ Teknologi yang Digunakan

### Frontend (Flutter)

- **Flutter SDK** - Framework UI cross-platform
- **Dart** - Bahasa pemrograman
- **Speech-to-Text Plugin** - Untuk fitur STT
- **Flutter TTS Plugin** - Untuk fitur TTS

### Backend (Django)

- **Python Django** - Framework web backend
- **SQLite Database** - Database untuk penyimpanan data
- **Django REST API** - API untuk komunikasi frontend-backend
- **LLM Integration** - Integrasi dengan Large Language Model

## 📋 Prasyarat

Pastikan Anda telah menginstal:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi terbaru)
- [Dart SDK](https://dart.dev/get-dart)
- [Python 3.8+](https://www.python.org/downloads/)
- [Android Studio](https://developer.android.com/studio) atau [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

## 🚀 Instalasi dan Setup

### 1. Clone Repository

```bash
git clone https://github.com/Ghozi-Waridi/_debat_app_with_LLAMA_.git
cd debate_app
```

### 2. Setup Flutter App

```bash
# Install dependencies Flutter
flutter pub get

# Jalankan Flutter Doctor untuk memastikan setup correct
flutter doctor
```

### 3. Setup Backend Django

```bash
# Masuk ke folder backend
cd backend

# Aktifkan virtual environment
source env/bin/activate  # Linux/Mac
# atau
env\Scripts\activate     # Windows

# Install dependencies Python
pip install -r requirements.txt

# Jalankan migrasi database
python manage.py migrate

# Buat superuser (opsional)
python manage.py createsuperuser

# Jalankan server Django
python manage.py runserver
```

### 4. Konfigurasi

- Pastikan backend Django berjalan di `http://127.0.0.1:8000/`
- Update endpoint API di konfigurasi Flutter jika diperlukan

## 🏃‍♂️ Menjalankan Aplikasi

### Jalankan Backend

```bash
cd backend
source env/bin/activate
python manage.py runserver
```

### Jalankan Flutter App

```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Untuk platform spesifik
flutter run -d android
flutter run -d ios
flutter run -d chrome
```

## 📁 Struktur Proyek

```
debate_app/
├── lib/                     # Source code Flutter
│   ├── main.dart           # Entry point aplikasi
│   ├── injection.dart      # Dependency injection
│   ├── core/               # Core utilities dan konfigurasi
│   │   ├── config/         # Konfigurasi aplikasi
│   │   └── theme/          # Theme dan styling
│   ├── features/           # Fitur-fitur utama
│   │   ├── Debate/         # Modul debat
│   │   ├── Stt/            # Speech-to-Text
│   │   └── Topics/         # Manajemen topik
│   └── shared/             # Komponen bersama
│       └── utils/          # Utilities
├── backend/                # Backend Django
│   ├── manage.py          # Django management script
│   ├── db.sqlite3         # Database SQLite
│   ├── apichat/           # API chat module
│   └── debat_LLM/         # Main Django project
├── android/               # Platform Android
├── ios/                   # Platform iOS
├── web/                   # Platform Web
├── test/                  # Unit dan widget tests
└── pubspec.yaml          # Dependencies Flutter
```

## 🔧 API Endpoints

Backend menyediakan beberapa endpoint utama:

- `GET /api/topics/` - Mengambil daftar topik debat
- `POST /api/chat/` - Mengirim pesan chat
- `GET /api/debates/` - Mengambil riwayat debat
- `POST /api/debates/` - Membuat sesi debat baru

## 🧪 Testing

```bash
# Jalankan unit tests
flutter test

# Jalankan integration tests
flutter drive --target=test_driver/app.dart

# Test backend Django
cd backend
python manage.py test
```

## 📱 Build untuk Production

### Android APK

```bash
flutter build apk --release
```

### Android AAB (untuk Play Store)

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 🤝 Kontribusi

1. Fork repository ini
2. Buat branch fitur baru (`git checkout -b fitur-amazing`)
3. Commit perubahan Anda (`git commit -m 'Menambahkan fitur amazing'`)
4. Push ke branch (`git push origin fitur-amazing`)
5. Buat Pull Request

## 📞 Kontak

- **Developer**: Ghozi Waridi
- **Repository**: [_debat_app_with_LLAMA_](https://github.com/Ghozi-Waridi/_debat_app_with_LLAMA_)

## 📄 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

## 🙏 Acknowledgments

- Flutter Team untuk framework yang luar biasa
- Django Team untuk backend framework
- Komunitas open source untuk berbagai plugin dan libraries

---

_Dibuat dengan ❤️ menggunakan Flutter dan Django_
