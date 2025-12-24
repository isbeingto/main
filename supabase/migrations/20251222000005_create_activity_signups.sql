-- Create activity_signups table for FARM-T07
CREATE TABLE IF NOT EXISTS public.activity_signups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  activity_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
  qty INTEGER NOT NULL DEFAULT 1 CHECK (qty > 0),
  total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
  note TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create index on user_id for faster user bookings query
CREATE INDEX idx_activity_signups_user_id ON public.activity_signups(user_id);

-- Create index on activity_id for faster activity lookups
CREATE INDEX idx_activity_signups_activity_id ON public.activity_signups(activity_id);

-- Add updated_at trigger
CREATE TRIGGER set_activity_signups_updated_at
  BEFORE UPDATE ON public.activity_signups
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

-- Enable RLS
ALTER TABLE public.activity_signups ENABLE ROW LEVEL SECURITY;

-- RLS policies
-- Users can view their own signups
CREATE POLICY "Users can view own activity signups"
  ON public.activity_signups
  FOR SELECT
  USING (auth.uid() = user_id);

-- Users can create their own signups
CREATE POLICY "Users can create own activity signups"
  ON public.activity_signups
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own signups
CREATE POLICY "Users can update own activity signups"
  ON public.activity_signups
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Comment
COMMENT ON TABLE public.activity_signups IS 'Activity signup records for FARM-T07';
