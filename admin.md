<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin — Undangan Sansan & Rahma</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Afacad:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
* { box-sizing: border-box; }
body { font-family: 'Afacad', sans-serif; background: #f0f4f8; color: #1a2e3b; font-size: 16px; margin: 0; }

.page { display: none; min-height: 100vh; padding-bottom: 80px; }
.page.active { display: block; }

.login-page { display: flex; align-items: center; justify-content: center; min-height: 100vh; background: #f0f4f8; }
.login-box { background: #fff; padding: 32px 24px; border-radius: 20px; box-shadow: 0 4px 24px rgba(74,125,181,0.1); border: 1px solid #e2eaf0; width: 100%; max-width: 360px; text-align: center; }

.bnav {
  position: fixed; bottom: 0; left: 0; right: 0; z-index: 200;
  background: #fff; border-top: 1px solid #e2eaf0;
  box-shadow: 0 -2px 16px rgba(74,125,181,0.08);
  display: flex; padding: 6px 0 env(safe-area-inset-bottom,6px);
}
.bnav-btn {
  flex: 1; display: flex; flex-direction: column; align-items: center;
  gap: 3px; padding: 6px 4px; border: none; background: transparent;
  cursor: pointer; font-family: 'Afacad', sans-serif; transition: all 0.2s;
}
.bnav-btn svg { width: 22px; height: 22px; transition: stroke 0.2s; }
.bnav-btn span { font-size: 0.65rem; font-weight: 600; color: #9ab0be; transition: color 0.2s; }
.bnav-btn.active span { color: #4A7DB5; }
.bnav-btn .dot { width: 4px; height: 4px; border-radius: 50%; background: #4A7DB5; opacity: 0; transition: opacity 0.2s; }
.bnav-btn.active .dot { opacity: 1; }

.page-header {
  background: #fff; border-bottom: 1px solid #e2eaf0;
  padding: 16px; position: sticky; top: 0; z-index: 100;
  display: flex; align-items: center; justify-content: space-between;
}
.page-title { font-size: 1.1rem; font-weight: 700; color: #1a3a5c; }
.page-sub { font-size: 0.8rem; color: #6a8898; margin-top: 1px; }

.card { background: #fff; border-radius: 16px; padding: 20px; border: 1px solid #e2eaf0; }
.stat-card { background: #fff; border-radius: 14px; padding: 18px 16px; border: 1px solid #e2eaf0; }
.stat-num { font-size: 2.2rem; font-weight: 700; line-height: 1; }
.stat-lbl { font-size: 0.8rem; font-weight: 600; color: #6a8898; margin-top: 4px; }

.input {
  width: 100%; padding: 13px 16px; border: 1px solid #d0dde8;
  border-radius: 10px; font-family: 'Afacad', sans-serif;
  font-size: 1rem; outline: none; color: #1a2e3b; transition: border-color 0.2s;
}
.input:focus { border-color: #4A7DB5; }
.input::placeholder { color: #9ab0be; }

.btn { padding: 12px 20px; border-radius: 10px; font-family: 'Afacad', sans-serif; font-size: 1rem; font-weight: 600; cursor: pointer; transition: all 0.2s; border: none; }
.btn-blue { background: #4A7DB5; color: #fff; }
.btn-blue:hover { background: #3a6a9e; }
.btn-blue:disabled { background: #a0b8d0; cursor: not-allowed; }
.btn-outline { background: transparent; color: #4A7DB5; border: 1px solid #4A7DB5; }
.btn-outline:hover { background: rgba(74,125,181,0.07); }
.btn-sm { padding: 8px 14px; font-size: 0.88rem; border-radius: 8px; }
.btn-danger { background: #fee2e2; color: #dc2626; }

.guest-item { background: #fff; border: 1px solid #e2eaf0; border-radius: 12px; padding: 14px 16px; margin-bottom: 10px; }
.guest-item:last-child { margin-bottom: 0; }
.guest-name { font-size: 1rem; font-weight: 700; color: #1a2e3b; }
.guest-meta { font-size: 0.85rem; color: #6a8898; margin-top: 2px; }
.guest-actions { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 10px; }

.badge { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
.badge-hadir { background: #dcfce7; color: #16a34a; }
.badge-tidak { background: #fee2e2; color: #dc2626; }
.badge-ragu  { background: #fef9c3; color: #ca8a04; }

.dropzone { border: 2px dashed #b8d0e8; border-radius: 12px; padding: 28px 16px; text-align: center; cursor: pointer; transition: all 0.2s; background: #f8fbff; }
.dropzone:hover, .dropzone.over { border-color: #4A7DB5; background: rgba(74,125,181,0.05); }

.toast { position: fixed; top: 16px; left: 50%; transform: translateX(-50%) translateY(-80px); padding: 12px 22px; background: #fff; border: 1px solid #d0dde8; border-radius: 10px; color: #4A7DB5; font-size: 0.95rem; font-weight: 600; box-shadow: 0 4px 20px rgba(74,125,181,0.12); z-index: 999; transition: transform 0.35s ease; white-space: nowrap; }
.toast.show { transform: translateX(-50%) translateY(0); }

.prev-row { display: flex; align-items: center; gap: 10px; padding: 10px 0; border-bottom: 1px solid #f0f4f8; }
.prev-row:last-child { border-bottom: none; }
.prev-num { width: 26px; height: 26px; border-radius: 50%; background: rgba(74,125,181,0.1); color: #4A7DB5; font-size: 0.75rem; font-weight: 700; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
</style>
</head>
<body>

<div class="toast" id="toast"></div>

<!-- LOGIN PAGE -->
<div class="login-page" id="loginPage">
  <div class="login-box">
    <div class="font-bold text-xl text-[#1a3a5c] mb-1">Admin Login</div>
    <div class="text-sm text-[#6a8898] mb-6">Masukkan password untuk mengakses panel</div>
    <input type="password" id="adminPass" class="input mb-4" placeholder="Password Admin">
    <button onclick="loginAdmin()" class="btn btn-blue w-full">Masuk</button>
  </div>
</div>

<!-- MAIN APP -->
<div id="appContainer" style="display:none;">

<!-- HOME -->
<div class="page active" id="pageHome">
  <div class="page-header">
    <div>
      <div class="page-title">Dashboard</div>
      <div class="page-sub">Sansan & Rahma · 06 Juni 2026</div>
    </div>
    <a href="index.html" target="_blank" class="btn btn-outline btn-sm">Undangan ↗</a>
  </div>
  <div class="px-4 py-5 space-y-4">
    <div class="grid grid-cols-2 gap-3">
      <div class="stat-card"><div class="stat-num text-[#4A7DB5]" id="sTotal">—</div><div class="stat-lbl">Total RSVP</div></div>
      <div class="stat-card"><div class="stat-num text-green-500" id="sHadir">—</div><div class="stat-lbl">Hadir</div></div>
      <div class="stat-card"><div class="stat-num text-red-400" id="sTidak">—</div><div class="stat-lbl">Tidak Hadir</div></div>
      <div class="stat-card"><div class="stat-num text-yellow-500" id="sRagu">—</div><div class="stat-lbl">Masih Ragu</div></div>
    </div>
    <button onclick="loadStats()" class="btn btn-outline w-full btn-sm">↻ Refresh Data</button>
  </div>
</div>

<!-- TAMBAH TAMU -->
<div class="page" id="pageTambah">
  <div class="page-header"><div><div class="page-title">Tambah Tamu</div><div class="page-sub">Input manual satu per satu</div></div></div>
  <div class="px-4 py-5 space-y-4">
    <div class="card space-y-3">
      <input type="text" id="guestName" class="input" placeholder="Nama tamu, misal: Budi Santoso">
      <input type="tel" id="guestPhone" class="input" placeholder="No HP (08...)">
      <button onclick="addGuest()" id="addBtn" class="btn btn-blue w-full">+ Tambah Tamu</button>
    </div>
    <div class="card">
      <div class="flex items-center justify-between mb-4">
        <p class="font-bold text-[#1a3a5c]">Daftar Tamu <span id="guestCount" class="text-[#4A7DB5]"></span></p>
        <button onclick="loadGuests()" class="btn btn-outline btn-sm">↻</button>
      </div>
      <div id="guestList"><p class="text-center text-[#6a8898] py-6">Memuat...</p></div>
    </div>
  </div>
</div>

<!-- RSVP -->
<div class="page" id="pageRsvp">
  <div class="page-header"><div><div class="page-title">Respon RSVP</div><div class="page-sub">Konfirmasi kehadiran tamu</div></div><button onclick="loadRsvp()" class="btn btn-outline btn-sm">↻</button></div>
  <div class="px-4 py-5"><div class="card"><div id="rsvpList"><p class="text-center text-[#6a8898] py-6">Memuat...</p></div></div></div>
</div>

<!-- SETTINGS -->
<div class="page" id="pageSettings">
  <div class="page-header"><div><div class="page-title">Pengaturan</div><div class="page-sub">Import tamu & musik latar</div></div></div>
  <div class="px-4 py-5 space-y-4">
    
    <!-- CSV Import -->
    <div class="card space-y-4">
      <div><p class="font-bold text-[#1a3a5c] mb-1">Import dari CSV</p><p class="text-sm text-[#6a8898]">Format: <code class="bg-blue-50 px-1 rounded text-[#4A7DB5]">Nama,NoHP</code></p></div>
      <button onclick="downloadTemplate()" class="btn btn-outline btn-sm w-full">⬇ Download Template CSV</button>
      <div class="dropzone" id="csvDrop" onclick="document.getElementById('csvFile').click()">
        <svg class="mx-auto mb-2" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#4A7DB5" stroke-width="1.5"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>
        <p class="text-sm font-semibold text-[#4A7DB5]">Klik atau drag & drop file CSV</p>
      </div>
      <input type="file" id="csvFile" accept=".csv" style="display:none" onchange="handleCsv(this)">
      <div id="csvPreview" style="display:none">
        <div class="flex items-center justify-between mb-2"><p class="text-sm font-semibold text-[#1a3a5c]"><span id="csvCount" class="text-[#4A7DB5]"></span> tamu ditemukan</p><button onclick="clearCsv()" class="btn btn-danger btn-sm">✕ Batal</button></div>
        <div id="csvRows" class="max-h-52 overflow-y-auto border border-[#e2eaf0] rounded-xl px-3 mb-3"></div>
        <button onclick="importCsv()" id="importBtn" class="btn btn-blue w-full">⬆ Import ke Database</button>
      </div>
    </div>

    <!-- Musik (TAMPILAN BARU: SIMPEL, TANPA URL) -->
    <div class="card space-y-4">
      <div>
        <p class="font-bold text-[#1a3a5c] mb-1">Musik Latar</p>
        <p class="text-sm text-[#6a8898]">Upload file MP3 langsung dari komputer (Maks 10MB).</p>
      </div>
      
      <!-- Status Musik Aktif -->
      <div id="currentMusicBox" style="display:none" class="p-3 bg-green-50 border border-green-200 rounded-xl">
        <p class="text-xs font-semibold text-green-600 mb-1">✅ Musik Aktif sekarang:</p>
        <p id="currentMusicUrl" class="text-xs text-[#1a3a5c] break-all"></p>
        <button onclick="removeMusic()" class="btn btn-danger btn-sm mt-2 w-full">Hapus Musik</button>
      </div>

      <!-- Area Upload -->
      <div id="uploadMusicBox">
        <div class="dropzone" id="musicDrop" onclick="document.getElementById('musicFile').click()">
          <svg class="mx-auto mb-2" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#4A7DB5" stroke-width="1.5"><path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/></svg>
          <p class="text-sm font-semibold text-[#4A7DB5]">Klik atau seret file MP3 di sini</p>
          <p class="text-xs text-[#8aabb8] mt-1">Format .mp3, .ogg, .wav</p>
        </div>
        <input type="file" id="musicFile" accept=".mp3,.ogg,.wav,audio/*" style="display:none" onchange="handleMusicFile(this)">
      </div>

      <!-- Info File yang dipilih -->
      <div id="musicFileInfo" style="display:none" class="p-3 bg-blue-50 rounded-xl space-y-3">
        <div class="flex items-center justify-between">
          <span class="text-sm font-semibold text-[#1a3a5c]" id="musicFileName">file.mp3</span>
          <button onclick="clearMusicFile()" class="text-sm text-red-500 font-semibold">✕ Batal</button>
        </div>
        <audio id="musicPlayer" controls class="w-full" style="height:36px;"></audio>
        <button onclick="saveMusic()" id="saveMusicBtn" class="btn btn-blue w-full">Upload & Simpan Musik</button>
      </div>

    </div>
  </div>
</div>

<!-- BOTTOM NAV -->
<nav class="bnav">
  <button class="bnav-btn active" id="bnHome" onclick="goPage('Home')"><svg viewBox="0 0 24 24" fill="none" stroke="#4A7DB5" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg><span>Home</span><div class="dot"></div></button>
  <button class="bnav-btn" id="bnTambah" onclick="goPage('Tambah')"><svg viewBox="0 0 24 24" fill="none" stroke="#9ab0be" stroke-width="2" id="svgTambah"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="16" y1="11" x2="22" y2="11"/></svg><span>Tamu</span><div class="dot"></div></button>
  <button class="bnav-btn" id="bnRsvp" onclick="goPage('Rsvp')"><svg viewBox="0 0 24 24" fill="none" stroke="#9ab0be" stroke-width="2" id="svgRsvp"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg><span>RSVP</span><div class="dot"></div></button>
  <button class="bnav-btn" id="bnSettings" onclick="goPage('Settings')"><svg viewBox="0 0 24 24" fill="none" stroke="#9ab0be" stroke-width="2" id="svgSettings"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg><span>Setelan</span><div class="dot"></div></button>
</nav>

</div>

<script>
const SUPABASE_URL = 'https://usgqptxcpudatklkhucs.supabase.co';

// ⚠️ WAJIB GANTI DENGAN SERVICE ROLE KEY TERBARU ANDA DARI SUPABASE!
const SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVzZ3FwdHhjcHVkYXRrbGtodWNzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NjU4OTYzMywiZXhwIjoyMDkyMTY1NjMzfQ.MC_-ZzW5KZNdArDZiv_5GHQgHq2OvyB1XvYqrQVSmNY'; 


let db = null; 
const BASE = window.location.origin + '/';

const ADMIN_PASSWORD = 'admin123ABC'; 

async function initDatabase() {
  if (!window.supabase) throw new Error('Supabase JS tidak ditemukan.');
  db = supabase.createClient(SUPABASE_URL, SERVICE_ROLE_KEY);
  const { data, error } = await db.from('rsvp').select('id').limit(1);
  if (error) throw error;
  return data;
}

async function loginAdmin() {
  const passInput = document.getElementById('adminPass').value;
  if (passInput === ADMIN_PASSWORD) {
    try {
      await initDatabase();
      document.getElementById('loginPage').style.display = 'none';
      document.getElementById('appContainer').style.display = 'block';
      await loadStats(); 
      toast('Login berhasil! 💙');
    } catch (err) {
      console.error('Supabase connection failed:', err);
      toast('Koneksi gagal! Pastikan Service Role Key sudah benar.');
    }
  } else {
    toast('Password salah!');
  }
}
document.getElementById('adminPass').addEventListener('keydown', e => { if(e.key==='Enter') loginAdmin(); });

let toastTimer;
function toast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg; t.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => t.classList.remove('show'), 4000);
}

function escapeHtml(str) { if (!str) return ''; return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;'); }
function timeAgo(d) {
  const m = Math.floor((Date.now() - new Date(d)) / 60000);
  if (m < 1) return 'Baru saja'; if (m < 60) return m + ' mnt lalu'; if (m < 1440) return Math.floor(m/60) + ' jam lalu'; return Math.floor(m/1440) + ' hari lalu';
}
function fmtPhone(p) { p = String(p).replace(/\D/g,''); if (p.startsWith('0')) p = '62'+p.slice(1); else if (p.startsWith('8')) p = '62'+p; return p; }
function waMsg(name, link) { return encodeURIComponent('Assalamualaikum Wr. Wb.\n\nKepada Yth.\n'+name+'\n\nKami mengundang Bapak/Ibu/Saudara/i untuk hadir di pernikahan kami.\n\nBuka undangan di:\n'+link+'\n\nTerima kasih. 💙\n\nWassalamualaikum Wr. Wb.'); }
const waIcon = `<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>`;

const pages = { Home:'pageHome', Tambah:'pageTambah', Rsvp:'pageRsvp', Settings:'pageSettings' };
const btns  = { Home:'bnHome', Tambah:'bnTambah', Rsvp:'bnRsvp', Settings:'bnSettings' };
const svgs  = { Tambah:'svgTambah', Rsvp:'svgRsvp', Settings:'svgSettings' };

function goPage(name) {
  Object.values(pages).forEach(id => document.getElementById(id).classList.remove('active'));
  document.getElementById(pages[name]).classList.add('active');
  Object.entries(btns).forEach(([k,id]) => document.getElementById(id).classList.toggle('active', k === name));
  Object.entries(svgs).forEach(([k,id]) => { const svg = document.getElementById(id); if (svg) svg.setAttribute('stroke', k === name ? '#4A7DB5' : '#9ab0be'); });
  if (name === 'Home') loadStats();
  if (name === 'Tambah') loadGuests();
  if (name === 'Rsvp') loadRsvp();
  if (name === 'Settings') loadMusicSettings();
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

async function loadStats() { const { data, error } = await db.from('rsvp').select('status'); if (error || !data) { console.error(error); return; } document.getElementById('sTotal').textContent = data.length; document.getElementById('sHadir').textContent = data.filter(r=>r.status==='hadir').length; document.getElementById('sTidak').textContent = data.filter(r=>r.status==='tidak').length; document.getElementById('sRagu').textContent = data.filter(r=>r.status==='ragu').length; }

async function loadGuests() {
  const { data, error } = await db.from('guests').select('*').order('created_at',{ascending:false});
  const el = document.getElementById('guestList'); if (error) { el.innerHTML = '<p class="text-center text-red-400 py-6">Gagal memuat data.</p>'; return console.error(error); }
  document.getElementById('guestCount').textContent = data ? '('+data.length+')' : '';
  if (!data || data.length === 0) { el.innerHTML = '<p class="text-center text-[#6a8898] py-6">Belum ada tamu.</p>'; return; }
  el.innerHTML = data.map((g,i) => { const link = g.link || (BASE+'?to='+encodeURIComponent(g.name)); const ph = g.phone ? fmtPhone(g.phone) : ''; const wa = ph ? 'https://wa.me/'+ph+'?text='+waMsg(g.name,link) : 'https://wa.me/?text='+waMsg(g.name,link); return `<div class="guest-item"><div class="guest-name">${i+1}. ${escapeHtml(g.name)}</div><div class="guest-meta">${escapeHtml(g.phone)||'No HP'} · ${timeAgo(g.created_at)}</div><div class="guest-actions"><button class="btn btn-outline btn-sm" onclick="copyLink('${link}')">Salin Link</button><a href="${wa}" target="_blank" class="btn btn-sm" style="background:#25D366;color:#fff;display:inline-flex;align-items:center;gap:5px;">${waIcon} Kirim WA</a><button class="btn btn-danger btn-sm" onclick="delGuest('${g.id}')">Hapus</button></div></div>`; }).join('');
}
async function addGuest() { const name = document.getElementById('guestName').value.trim(); const phone = document.getElementById('guestPhone').value.trim(); if (!name) { toast('Nama tidak boleh kosong'); return; } const btn = document.getElementById('addBtn'); btn.disabled = true; btn.textContent = 'Menyimpan...'; const { error } = await db.from('guests').insert({ name, phone: phone||null, link: BASE+'?to='+encodeURIComponent(name) }); btn.disabled = false; btn.textContent = '+ Tambah Tamu'; if (error) { toast('Gagal: '+error.message); return; } document.getElementById('guestName').value = ''; document.getElementById('guestPhone').value = ''; toast('Tamu ditambahkan 💙'); loadGuests(); }
async function delGuest(id) { if (!confirm('Hapus tamu ini?')) return; const { error } = await db.from('guests').delete().eq('id',id); if (error) { toast('Gagal menghapus'); return; } toast('Tamu dihapus'); loadGuests(); }
function copyLink(link) { navigator.clipboard.writeText(link).then(()=>toast('Link disalin 💙')); }
document.getElementById('guestName').addEventListener('keydown', e => { if(e.key==='Enter') document.getElementById('guestPhone').focus(); });
document.getElementById('guestPhone').addEventListener('keydown', e => { if(e.key==='Enter') addGuest(); });

async function loadRsvp() {
  const { data, error } = await db.from('rsvp').select('*').order('created_at',{ascending:false}); const el = document.getElementById('rsvpList');
  if (error) { el.innerHTML = '<p class="text-center text-red-400 py-6">Gagal memuat data.</p>'; return console.error(error); }
  if (!data || data.length === 0) { el.innerHTML = '<p class="text-center text-[#6a8898] py-6">Belum ada respon RSVP.</p>'; return; }
  const bc = { hadir:'badge-hadir', tidak:'badge-tidak', ragu:'badge-ragu' }; const bl = { hadir:'✅ Hadir', tidak:'❌ Tidak Hadir', ragu:'🤔 Masih Ragu' };
  el.innerHTML = data.map((r,i) => `<div class="guest-item"><div class="flex items-start justify-between gap-2"><div><div class="guest-name">${i+1}. ${escapeHtml(r.name)}</div><div class="guest-meta">Diundang: ${escapeHtml(r.guest_param)||'—'}</div></div><span class="badge ${bc[r.status]||''}">${bl[r.status]||r.status}</span></div><div class="guest-meta mt-1">👥 ${r.guest_count||1} orang · ${timeAgo(r.created_at)}</div>${r.wish ? '<div class="mt-2 text-sm text-[#2c5060] bg-blue-50 rounded-lg px-3 py-2">"'+escapeHtml(r.wish)+'"</div>' : ''}<div class="guest-actions mt-2 justify-end"><button class="btn btn-danger btn-sm" onclick="delRsvp('${r.id}')">Hapus</button></div></div>`).join('');
}
async function delRsvp(id) { if (!confirm('Hapus data RSVP ini?')) return; const { error } = await db.from('rsvp').delete().eq('id',id); if (error) { toast('Gagal menghapus'); return; } toast('RSVP dihapus'); loadRsvp(); loadStats(); }

let csvRows = [];
const csvDrop = document.getElementById('csvDrop');
csvDrop.addEventListener('dragover', e => { e.preventDefault(); csvDrop.classList.add('over'); }); csvDrop.addEventListener('dragleave', () => csvDrop.classList.remove('over')); csvDrop.addEventListener('drop', e => { e.preventDefault(); csvDrop.classList.remove('over'); if(e.dataTransfer.files[0]) parseCsv(e.dataTransfer.files[0]); });
function handleCsv(input) { if(input.files[0]) parseCsv(input.files[0]); }
function parseCsv(file) { if (!file.name.endsWith('.csv')) { toast('Hanya file .csv'); return; } const reader = new FileReader(); reader.onload = e => { const lines = e.target.result.split('\n').map(l=>l.trim()).filter(l=>l); csvRows = []; for (let i = 1; i < lines.length; i++) { const p = lines[i].split(','); const name = (p[0]||'').trim(), phone = (p[1]||'').trim(); if (name) csvRows.push({ name, phone }); } if (!csvRows.length) { toast('Tidak ada data valid'); return; } document.getElementById('csvCount').textContent = csvRows.length; document.getElementById('csvRows').innerHTML = csvRows.map((g,i) => `<div class="prev-row"><div class="prev-num">${i+1}</div><div><span class="font-semibold text-sm">${escapeHtml(g.name)}</span><span class="text-xs text-[#6a8898] ml-2">${escapeHtml(g.phone)||'No HP'}</span></div></div>`).join(''); document.getElementById('csvPreview').style.display = 'block'; }; reader.readAsText(file); }
function clearCsv() { csvRows = []; document.getElementById('csvPreview').style.display = 'none'; document.getElementById('csvFile').value = ''; }
async function importCsv() { if (!csvRows.length) return; const btn = document.getElementById('importBtn'); btn.disabled = true; btn.textContent = 'Mengimpor...'; const rows = csvRows.map(g => ({ name: g.name, phone: g.phone||null, link: BASE+'?to='+encodeURIComponent(g.name) })); const { error } = await db.from('guests').insert(rows); btn.disabled = false; btn.textContent = '⬆ Import ke Database'; if (error) { toast('Gagal: '+error.message); console.error(error); return; } toast(csvRows.length+' tamu diimport 💙'); clearCsv(); loadGuests(); }
function downloadTemplate() { const a = document.createElement('a'); a.href = URL.createObjectURL(new Blob(['Nama,NoHP\nBudi Santoso,08123456789\nSiti Rahayu,08987654321'],{type:'text/csv'})); a.download = 'template_tamu.csv'; a.click(); }

/* ── MUSIK (VERSI SIMPEL TANPA URL) ── */
let musicBlob = null;
const musicDrop = document.getElementById('musicDrop');
musicDrop.addEventListener('dragover', e => { e.preventDefault(); musicDrop.classList.add('over'); }); musicDrop.addEventListener('dragleave', () => musicDrop.classList.remove('over')); musicDrop.addEventListener('drop', e => { e.preventDefault(); musicDrop.classList.remove('over'); if(e.dataTransfer.files[0]) setMusicFile(e.dataTransfer.files[0]); });

function handleMusicFile(input) { if(input.files[0]) setMusicFile(input.files[0]); }

function setMusicFile(file) {
  if (!file.type.startsWith('audio/')) { toast('Hanya file audio yang diizinkan'); return; }
  if (file.size > 10000000) { toast('File terlalu besar (Maks 10MB)'); return; }
  musicBlob = file;
  document.getElementById('musicFileName').textContent = file.name;
  document.getElementById('musicPlayer').src = URL.createObjectURL(file);
  document.getElementById('musicFileInfo').style.display = 'block';
  document.getElementById('uploadMusicBox').style.display = 'none'; // Sembunyikan dropzone saat file dipilih
}

function clearMusicFile() { 
  musicBlob = null; 
  document.getElementById('musicFileInfo').style.display = 'none'; 
  document.getElementById('musicFile').value = ''; 
  document.getElementById('uploadMusicBox').style.display = 'block'; // Tampilkan dropzone lagi
}

async function loadMusicSettings() {
  const { data, error } = await db.from('settings').select('value').eq('key','music_url').single();
  const url = data?.value || '';
  document.getElementById('currentMusicUrl').textContent = url ? 'File tersimpan di cloud' : '';
  document.getElementById('currentMusicBox').style.display = url ? 'block' : 'none';
  document.getElementById('uploadMusicBox').style.display = url ? 'none' : 'block'; // Sembunyikan upload jika sudah ada musik
  clearMusicFile(); // Reset form upload
}

async function saveMusic() {
  const btn = document.getElementById('saveMusicBtn');
  if (!musicBlob) { toast('Pilih file musik terlebih dahulu!'); return; }
  
  btn.disabled = true; 
  btn.textContent = '1/2 Mengupload...';
  toast('⏳ Proses upload dimulai, mohon tunggu...');
  
  try {
    const fileName = 'musik_undangan_' + Date.now() + '.mp3';
    
    const { data: uploadData, error: uploadError } = await db.storage
      .from('musik') // PASTIKAN BUCKET "musik" SUDAH DIBUAT & PUBLIC DI SUPABASE
      .upload(fileName, musicBlob, { cacheControl: '3600', upsert: true });

    if (uploadError) {
      console.error('Upload Error:', uploadError);
      toast('❌ Gagal upload: ' + uploadError.message);
      throw uploadError;
    }

    btn.textContent = '2/2 Menyimpan...';
    const { data: urlData } = db.storage.from('musik').getPublicUrl(fileName);
    const finalUrl = urlData.publicUrl;

    const { error } = await db.from('settings').upsert({ key:'music_url', value:finalUrl, updated_at:new Date().toISOString() },{ onConflict:'key' });
    if (error) throw error;
    
    toast('✅ Musik berhasil diupload & disimpan!'); 
    loadMusicSettings(); // Ini akan otomatis menyembunyikan form upload dan menampilkan status hijau
  } catch (err) { 
    console.error('Save Music Error:', err); 
    toast('❌ Gagal menyimpan musik. Cek console (F12).'); 
    btn.disabled = false; btn.textContent = 'Upload & Simpan Musik';
  }
}

async function removeMusic() {
  if (!confirm('Hapus musik latar?')) return;
  const { error } = await db.from('settings').upsert({ key:'music_url', value:'', updated_at:new Date().toISOString() },{ onConflict:'key' });
  if (error) { toast('Gagal menghapus'); return; }
  toast('Musik dihapus'); loadMusicSettings();
}
</script>
</body>
</html>