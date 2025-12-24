-- ============================================================================
-- FARM-T06: Create lodging_bookings table for confirmed bookings
-- ============================================================================

-- ============================================================================
-- 1. LODGING_BOOKINGS TABLE (民宿预订记录)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.lodging_bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    lodging_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    nights INTEGER NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL DEFAULT 0,
    guests INTEGER DEFAULT 1,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    note TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_lodging_bookings_user_id ON public.lodging_bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_lodging_bookings_lodging_id ON public.lodging_bookings(lodging_id);
CREATE INDEX IF NOT EXISTS idx_lodging_bookings_status ON public.lodging_bookings(status);
CREATE INDEX IF NOT EXISTS idx_lodging_bookings_start_date ON public.lodging_bookings(start_date);

-- ============================================================================
-- 2. TRIGGERS
-- ============================================================================
-- Apply updated_at trigger to lodging_bookings
DROP TRIGGER IF EXISTS update_lodging_bookings_updated_at ON public.lodging_bookings;
CREATE TRIGGER update_lodging_bookings_updated_at
    BEFORE UPDATE ON public.lodging_bookings
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- ============================================================================
-- 3. ROW LEVEL SECURITY (RLS)
-- ============================================================================
ALTER TABLE public.lodging_bookings ENABLE ROW LEVEL SECURITY;

-- Users can view their own bookings
DROP POLICY IF EXISTS "Users can view their own bookings" ON public.lodging_bookings;
CREATE POLICY "Users can view their own bookings"
ON public.lodging_bookings
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- Users can create their own bookings
DROP POLICY IF EXISTS "Users can create bookings" ON public.lodging_bookings;
CREATE POLICY "Users can create bookings"
ON public.lodging_bookings
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- Users can update their own bookings (e.g., cancel)
DROP POLICY IF EXISTS "Users can update their own bookings" ON public.lodging_bookings;
CREATE POLICY "Users can update their own bookings"
ON public.lodging_bookings
FOR UPDATE
TO authenticated
USING (auth.uid() = user_id);
