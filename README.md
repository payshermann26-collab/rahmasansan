# Undangan Sansan & Rahma

Aplikasi undangan pernikahan online dengan admin panel.

## 📁 Struktur Project

```
undangan/
├── public/
│   └── index.html              ← Halaman undangan publik (diakses orang)
├── admin/
│   └── admin.html              ← Panel admin (hanya admin)
├── _redirects                  ← Cloudflare routing config
├── README.md                   ← File ini
├── spb.md                      ← Catatan Supabase
└── .git/                       ← Git repository
```

## 🚀 Deployment

**Sudah deploy ke Cloudflare Pages:**
- `index.html` → publik di `https://domain.com/`
- `admin.html` → akses via `https://domain.com/admin/`

## 📋 Fitur

### Halaman Undangan (`public/index.html`)
- Dashboard dengan statistik RSVP
- Daftar tamu
- Form RSVP
- Pengaturan musik latar

### Admin Panel (`admin/admin.html`)
- Login dengan password
- Tambah tamu manual
- Import tamu dari CSV
- Lihat statistik RSVP
- Kelola musik latar
- Password: `admin123`

## 🔧 Teknologi

- **Frontend:** HTML, CSS (Tailwind), JavaScript
- **Database:** Supabase PostgreSQL
- **Hosting:** Cloudflare Pages
- **CDN:** jsDelivr (Tailwind, Supabase JS)

## 📊 Database Tables

### `guests`
- `id` (UUID) - Primary key
- `name` (text) - Nama tamu
- `phone` (text) - Nomor HP
- `link` (text) - Link undangan personal
- `created_at` (timestamp) - Waktu input

### `rsvp`
- `id` (UUID) - Primary key
- `name` (text) - Nama yang merespon
- `status` (text) - 'hadir' | 'tidak' | 'ragu'
- `guest_param` (text) - Nama tamu yang diundang
- `guest_count` (integer) - Jumlah yang akan hadir
- `wish` (text) - Doa/ucapan
- `created_at` (timestamp) - Waktu respon

### `settings`
- `key` (text) - Primary key (misal: 'music_url')
- `value` (text) - Nilai setting
- `updated_at` (timestamp) - Waktu update

## 🔑 Konfigurasi Supabase

**Project URL:**
```
https://usgqptxcpudatklkhucs.supabase.co
```

**API Key (Anon - untuk public):**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVzZ3FwdHhjcHVkYXRrbGtodWNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY1ODk2MzMsImV4cCI6MjA5MjE2NTYzM30.il3v1knHRKNPTYnS9Uhz6RgM50-TCzzCXTO2tGqWuKw
```

## 📱 Cara Menggunakan

### Untuk Tamu (Undangan Publik)
1. Buka `https://domain.com/`
2. Lihat dashboard dan form RSVP
3. Isi data untuk konfirmasi kehadiran

### Untuk Admin
1. Buka `https://domain.com/admin/`
2. Login dengan password: `admin123`
3. Kelola data tamu dan lihat RSVP

## 📝 Git Commands

```bash
# Commit perubahan
git add .
git commit -m "deskripsi perubahan"
git push -u origin main

# Lihat status
git status
```

## ⚙️ Maintenance

- Ganti `ADMIN_PASSWORD` di `admin/admin.html` untuk keamanan
- Monitor Supabase usage di dashboard
- Backup data secara berkala
- Update Cloudflare DNS jika diperlukan

---

**Last Updated:** May 13, 2026
