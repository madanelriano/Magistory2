#Magistory (Full Stack)

Aplikasi web AI Video Editor & Generator yang memungkinkan pengguna membuat video pendek (Shorts/TikTok/Reels) hanya dengan satu kalimat teks, atau mengeditnya secara manual menggunakan timeline multi-track yang canggih.
1. Tumpukan Teknologi (Tech Stack)
Frontend: React 18+ (Vite), TypeScript, Tailwind CSS.
State Management: React Context API atau Zustand.
Backend: Node.js dengan Express (untuk API & Rendering Server).
Database: Prisma (PostgreSQL/SQLite) atau JSON-file persistence sederhana untuk tahap awal.
AI Models: Google Gemini 2.5 Flash (untuk Scripting & Media Matching), Gemini TTS (Audio), Google Veo (Video Gen), Imagen 3 (Image Gen).
Media APIs: Pexels API (Video/Foto), Pixabay API (Audio/SFX).
Processing: fluent-ffmpeg di server-side untuk rendering video final.
2. Arsitektur & Fitur Utama
Aplikasi harus terdiri dari dua bagian utama: Frontend Editor dan Backend Renderer.
A. Fitur Frontend (Alur Pengguna)
Landing & Onboarding:
Halaman muka modern (Dark Mode/Cyberpunk aesthetic) dengan tombol CTA "Get Started".
Login via Google OAuth (gunakan @react-oauth/google).
Prompt Input (Generator Mode):
Input: Topik video, Durasi (30s, 1m), Rasio (Landscape/Portrait), Gaya Visual (Video/Image).
Fitur Audio-to-Video: Upload file MP3, AI menganalisis mood/lirik, dan membuat video visualisasi otomatis.
AI Logic (Gemini):
Prompt dikirim ke Gemini untuk menghasilkan JSON Script.
Script berisi daftar segments. Setiap segmen memiliki: narration_text, search_keywords (Subject + Action + Setting), dan duration.
Video Editor (The Core):
Timeline Visual:
Horizontal scrolling, zoomable time ruler (seconds).
Multi-Track: Track Visual (Video/Gambar) di atas, Track Audio (Musik/SFX/Voiceover) di bawah.
Interaksi: Drag & drop untuk mengubah urutan klip, drag ujung klip untuk trimming (mengubah durasi), split (memotong), delete.
Preview Player:
HTML5 Video player yang merender state timeline secara real-time.
Karaoke Subtitles: Overlay teks yang tersinkronisasi per kata (gunakan logika estimasi durasi kata).
Resource Panel (Sidebar):
Integrasi Pexels untuk mencari/mengganti stok video.
Integrasi Pixabay untuk mencari background music/SFX.
AI Tools Modal:
TTS: Generate suara narasi per segmen atau bulk generate untuk semua segmen.
Image Gen: Buat gambar baru jika stok tidak ada yang cocok.
Export:
Tombol export mengirim JSON data timeline ke Backend.
Tampilkan progress bar rendering (Polling status job).
B. Fitur Backend (Rendering Engine)
Job Queue: Terima request render, buat jobId.
Asset Downloading: Download semua media (URL Pexels, blob TTS) ke folder temp lokal.
FFmpeg Pipeline (Critical):
Gabungkan visual (Image/Video) sesuai durasi segmen.
Terapkan filter scale dan pad untuk menyesuaikan rasio (16:9 atau 9:16).
Terapkan transisi xfade (fade, slide, zoom) antar klip.
Generate file subtitle .ass (Advanced Substation Alpha) untuk hardcoded subtitles yang cantik.
Mixing audio (Narasi + Background Music dengan auto-ducking agar narasi terdengar jelas).
Output: Hasilkan file MP4 final untuk didownload.
3. Desain UI/UX (Aesthetics)
Tema: Gelap total (bg-gray-900), aksen ungu/neon (purple-600), teks putih.
Feel: Profesional seperti CapCut Web atau Canva Video.
Responsif: Editor harus bisa menyembunyikan panel samping di layar kecil, tapi diutamakan untuk Desktop.
Feedback: Loading spinners, progress bars, dan toast notifications untuk setiap aksi AI.
4. Struktur Data (TypeScript Interfaces)
Gunakan struktur data berikut sebagai acuan utama logika timeline:
code
TypeScript
interface Segment {
  id: string;
  narration_text: string;
  search_keywords_for_media: string; // Kata kunci visual untuk Pexels
  media: { id: string, url: string, type: 'video' | 'image' }[];
  audioUrl?: string; // URL Blob hasil TTS
  duration: number; // Detik
  transition: 'fade' | 'slide' | 'zoom';
  wordTimings?: { word: string, start: number, end: number }[]; // Untuk subtitle
}

interface VideoScript {
  title: string;
  segments: Segment[];
  backgroundMusic?: { url: string, volume: number };
  aspectRatio: 'landscape' | 'portrait';
}
5. Instruksi Implementasi Langkah demi Langkah
Langkah 1: Setup Proyek
Inisialisasi Vite + React + TS.
Setup Tailwind CSS.
Setup Backend folder dengan Express.
Langkah 2: Integrasi AI & Pexels (Service Layer)
Buat geminiService.ts: Fungsi generateVideoScript(topic) yang me-return JSON terstruktur.
Buat pexelsService.ts: Fungsi untuk mencari video/foto berdasarkan keyword dari Gemini.
Buat alur: User input topic -> Gemini JSON -> Loop JSON -> Fetch Pexels Media -> State React terisi.
Langkah 3: Membangun Timeline Editor
Buat komponen Timeline.tsx yang me-render segmen berdasarkan durasi (misal: 1 detik = 100px width).
Implementasikan logika playback yang menyinkronkan currentTime state dengan posisi scroll timeline dan preview video.
Langkah 4: Backend Rendering (FFmpeg)
Buat endpoint /render di Express.
Tulis logika fluent-ffmpeg yang kompleks untuk menggabungkan aset, menambah transisi, dan mem-burn subtitle.
Langkah 5: Polish & Integrasi Akhir
Tambahkan fitur Auth (opsional guest mode).
Tambahkan manajemen kredit (kuota penggunaan AI).
Pastikan styling konsisten dan animasi halus.
