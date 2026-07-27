-- Run this once in the Supabase SQL Editor for your project.

create table if not exists teams (
  team_name text primary key,
  daily_target numeric not null default 0,
  hours numeric not null default 0,
  updated_at timestamptz not null default now()
);

create table if not exists global_settings (
  id int primary key default 1,
  days_passed numeric not null default 0,
  total_days numeric not null default 0,
  updated_at timestamptz not null default now()
);

create table if not exists agents (
  id bigint generated always as identity primary key,
  team text not null,
  agent_name text not null,
  piryon numeric not null default 0,
  created_at timestamptz not null default now()
);

alter table teams enable row level security;
alter table global_settings enable row level security;
alter table agents enable row level security;

-- The dashboard has no login system, so the public anon key needs full
-- read/write access to these tables. Anyone with the key (visible in the
-- public GitHub repo) can read/write this data — acceptable only because
-- this is internal, non-sensitive operational data.
create policy "public full access" on teams for all using (true) with check (true);
create policy "public full access" on global_settings for all using (true) with check (true);
create policy "public full access" on agents for all using (true) with check (true);
