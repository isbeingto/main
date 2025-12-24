-- ============================================================================
-- FARM-T02: Create listings, listing_photos, and booking_requests tables
-- ============================================================================

-- ============================================================================
-- 1. LISTINGS TABLE (民宿/房源基础信息)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.listings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    location TEXT,
    price_per_night DECIMAL(10, 2),
    max_guests INTEGER DEFAULT 2,
    bedrooms INTEGER DEFAULT 1,
    bathrooms INTEGER DEFAULT 1,
    amenities TEXT[], -- Array of amenity strings
    host_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_listings_host_id ON public.listings(host_id);
CREATE INDEX IF NOT EXISTS idx_listings_is_active ON public.listings(is_active);

-- ============================================================================
-- 2. LISTING_PHOTOS TABLE (房源图片)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.listing_photos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    listing_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
    photo_url TEXT NOT NULL,
    caption TEXT,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_listing_photos_listing_id ON public.listing_photos(listing_id);

-- ============================================================================
-- 3. BOOKING_REQUESTS TABLE (预订意向/申请)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.booking_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    listing_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    guests INTEGER DEFAULT 1,
    note TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected', 'cancelled')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_booking_requests_listing_id ON public.booking_requests(listing_id);
CREATE INDEX IF NOT EXISTS idx_booking_requests_user_id ON public.booking_requests(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_requests_status ON public.booking_requests(status);

-- ============================================================================
-- 4. UPDATED_AT TRIGGER FUNCTION
-- ============================================================================
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger to listings
DROP TRIGGER IF EXISTS update_listings_updated_at ON public.listings;
CREATE TRIGGER update_listings_updated_at
    BEFORE UPDATE ON public.listings
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- Apply trigger to booking_requests
DROP TRIGGER IF EXISTS update_booking_requests_updated_at ON public.booking_requests;
CREATE TRIGGER update_booking_requests_updated_at
    BEFORE UPDATE ON public.booking_requests
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- ============================================================================
-- 5. ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE public.listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.listing_photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.booking_requests ENABLE ROW LEVEL SECURITY;

-- ----- LISTINGS POLICIES -----
-- Allow anyone (including anonymous) to read active listings
DROP POLICY IF EXISTS "Anyone can view active listings" ON public.listings;
CREATE POLICY "Anyone can view active listings"
    ON public.listings
    FOR SELECT
    USING (is_active = true);

-- Allow hosts to manage their own listings
DROP POLICY IF EXISTS "Hosts can manage their own listings" ON public.listings;
CREATE POLICY "Hosts can manage their own listings"
    ON public.listings
    FOR ALL
    USING (auth.uid() = host_id);

-- ----- LISTING_PHOTOS POLICIES -----
-- Allow anyone to view photos of active listings
DROP POLICY IF EXISTS "Anyone can view listing photos" ON public.listing_photos;
CREATE POLICY "Anyone can view listing photos"
    ON public.listing_photos
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.listings
            WHERE listings.id = listing_photos.listing_id
            AND listings.is_active = true
        )
    );

-- Allow hosts to manage photos of their listings
DROP POLICY IF EXISTS "Hosts can manage their listing photos" ON public.listing_photos;
CREATE POLICY "Hosts can manage their listing photos"
    ON public.listing_photos
    FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.listings
            WHERE listings.id = listing_photos.listing_id
            AND listings.host_id = auth.uid()
        )
    );

-- ----- BOOKING_REQUESTS POLICIES -----
-- Only authenticated users can create booking requests
DROP POLICY IF EXISTS "Authenticated users can create booking requests" ON public.booking_requests;
CREATE POLICY "Authenticated users can create booking requests"
    ON public.booking_requests
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Users can only read their own booking requests
DROP POLICY IF EXISTS "Users can view their own booking requests" ON public.booking_requests;
CREATE POLICY "Users can view their own booking requests"
    ON public.booking_requests
    FOR SELECT
    USING (auth.uid() = user_id);

-- Users can update their own booking requests (e.g., cancel)
DROP POLICY IF EXISTS "Users can update their own booking requests" ON public.booking_requests;
CREATE POLICY "Users can update their own booking requests"
    ON public.booking_requests
    FOR UPDATE
    USING (auth.uid() = user_id);

-- ============================================================================
-- 6. SEED DATA - Demo Listings
-- ============================================================================

-- Insert demo listings (without host_id so they're publicly visible)
INSERT INTO public.listings (id, title, description, location, price_per_night, max_guests, bedrooms, bathrooms, amenities, is_active)
VALUES
    (
        'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
        '田园小屋',
        '位于乡村的宁静小屋，享受纯净空气和星空夜晚。配有现代化设施，适合家庭度假或情侣出游。',
        '云南大理',
        388.00,
        4,
        2,
        1,
        ARRAY['WiFi', '厨房', '免费停车', '空调', '洗衣机'],
        true
    ),
    (
        'b2c3d4e5-f6a7-8901-bcde-f12345678901',
        '山间别墅',
        '坐落于青山绿水间的现代别墅，拥有私人泳池和花园。可欣赏壮丽山景，是放松身心的理想去处。',
        '浙江莫干山',
        1288.00,
        8,
        4,
        3,
        ARRAY['WiFi', '泳池', '花园', '烧烤区', '空调', '停车场', '电视'],
        true
    ),
    (
        'c3d4e5f6-a7b8-9012-cdef-123456789012',
        '海边度假屋',
        '临海而建的度假小屋，步行即可到达私人沙滩。每天早晨醒来即可聆听海浪声，感受海风轻拂。',
        '海南三亚',
        688.00,
        6,
        3,
        2,
        ARRAY['WiFi', '海景', '阳台', '空调', '厨房', '烧烤区'],
        true
    ),
    (
        'd4e5f6a7-b8c9-0123-def0-234567890123',
        '古镇民宿',
        '位于千年古镇核心区的传统民宿，保留原始建筑风貌的同时配备现代舒适设施。漫步古街，体验慢生活。',
        '江苏周庄',
        298.00,
        4,
        2,
        1,
        ARRAY['WiFi', '空调', '早餐', '茶室'],
        true
    ),
    (
        'e5f6a7b8-c9d0-1234-ef01-345678901234',
        '森林树屋',
        '独特的树屋体验，置身于茂密森林之中。与自然零距离接触，适合追求独特住宿体验的旅行者。',
        '四川峨眉山',
        528.00,
        2,
        1,
        1,
        ARRAY['WiFi', '观景台', '暖气', '热水浴缸'],
        true
    )
ON CONFLICT (id) DO NOTHING;

-- Insert demo photos for listings
INSERT INTO public.listing_photos (listing_id, photo_url, caption, display_order)
VALUES
    -- 田园小屋 photos
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?w=800', '外观', 1),
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800', '客厅', 2),
    
    -- 山间别墅 photos
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800', '别墅外观', 1),
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800', '泳池', 2),
    
    -- 海边度假屋 photos
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?w=800', '海边外观', 1),
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800', '卧室海景', 2),
    
    -- 古镇民宿 photos
    ('d4e5f6a7-b8c9-0123-def0-234567890123', 'https://images.unsplash.com/photo-1577058547854-d3a85e2c3a18?w=800', '传统建筑', 1),
    
    -- 森林树屋 photos
    ('e5f6a7b8-c9d0-1234-ef01-345678901234', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800', '树屋外观', 1)
ON CONFLICT DO NOTHING;

-- ============================================================================
-- DONE
-- ============================================================================
