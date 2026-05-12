-- RLS Policies untuk Undangan Sansan & Rahma
-- Jalankan di Supabase SQL Editor

-- Guests table policies
create policy "guests_allow_read" on public.guests for select using (true);
create policy "guests_allow_insert" on public.guests for insert with check (true);

-- RSVP table policies
create policy "rsvp_allow_read" on public.rsvp for select using (true);
create policy "rsvp_allow_insert" on public.rsvp for insert with check (true);

-- Settings table policies
create policy "settings_allow_read" on public.settings for select using (true);
create policy "settings_allow_insert" on public.settings for insert with check (true);
create policy "settings_allow_update" on public.settings for update using (true) with check (true);

-- Jika policy sudah ada, abaikan error