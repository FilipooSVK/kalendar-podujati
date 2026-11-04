-- Prehľad podujatí v2: verejný anonymný CRUD, bez účtov.
-- POZOR: každý návštevník môže pridávať, upravovať a mazať všetky podujatia.
-- Spusti v Supabase SQL Editor v NOVOM projekte.
create extension if not exists pgcrypto;
create table if not exists public.events (
 id uuid primary key default gen_random_uuid(),
 event_date date not null,
 title text not null check (char_length(trim(title)) between 1 and 200),
 municipality text not null default '' check (char_length(municipality) <= 160),
 venue text not null default '' check (char_length(venue) <= 200),
 time_from time,
 time_to time,
 description text not null default '' check (char_length(description) <= 3000),
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 constraint time_order check (time_from is null or time_to is null or time_to >= time_from)
);
create index if not exists events_event_date_idx on public.events(event_date);
create or replace function public.events_touch_updated_at() returns trigger
language plpgsql set search_path = '' as $$
begin new.updated_at = now(); return new; end; $$;
drop trigger if exists events_touch_updated_at_trigger on public.events;
create trigger events_touch_updated_at_trigger before update on public.events
for each row execute function public.events_touch_updated_at();
alter table public.events enable row level security;
drop policy if exists "public_read_events" on public.events;
drop policy if exists "public_insert_events" on public.events;
drop policy if exists "public_update_events" on public.events;
drop policy if exists "public_delete_events" on public.events;
create policy "public_read_events" on public.events for select to anon using (true);
create policy "public_insert_events" on public.events for insert to anon with check (true);
create policy "public_update_events" on public.events for update to anon using (true) with check (true);
create policy "public_delete_events" on public.events for delete to anon using (true);
grant usage on schema public to anon;
grant select, insert, update, delete on public.events to anon;
-- Odporúčané pri verejnom anonymnom zápise: Supabase ochrana proti zneužitiu / proxy s rate limitingom.
