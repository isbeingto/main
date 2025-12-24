-- ============================================================================
-- FARM-T05: Create products and product_orders tables
-- ============================================================================

-- ============================================================================
-- 1. PRODUCTS TABLE (商品)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0,
    category TEXT NOT NULL, -- 'agricultural', 'poultry', 'plants', 'cultural'
    image_url TEXT,
    stock INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for filtering
CREATE INDEX IF NOT EXISTS idx_products_category ON public.products(category);
CREATE INDEX IF NOT EXISTS idx_products_is_active ON public.products(is_active);

-- ============================================================================
-- 2. PRODUCT_ORDERS TABLE (商品订单)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.product_orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE SET NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    total_price DECIMAL(10, 2) NOT NULL DEFAULT 0,
    status TEXT DEFAULT 'pending', -- 'pending', 'paid', 'shipped', 'completed', 'cancelled'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_product_orders_user_id ON public.product_orders(user_id);
CREATE INDEX IF NOT EXISTS idx_product_orders_product_id ON public.product_orders(product_id);

-- ============================================================================
-- 3. TRIGGERS
-- ============================================================================
-- Apply updated_at trigger to products
DROP TRIGGER IF EXISTS update_products_updated_at ON public.products;
CREATE TRIGGER update_products_updated_at
    BEFORE UPDATE ON public.products
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- Apply updated_at trigger to product_orders
DROP TRIGGER IF EXISTS update_product_orders_updated_at ON public.product_orders;
CREATE TRIGGER update_product_orders_updated_at
    BEFORE UPDATE ON public.product_orders
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- ============================================================================
-- 4. RLS POLICIES
-- ============================================================================

-- Enable RLS
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_orders ENABLE ROW LEVEL SECURITY;

-- Products Policies
-- Everyone can view active products
CREATE POLICY "Everyone can view active products"
    ON public.products FOR SELECT
    USING (is_active = true);

-- Only admins/service_role can insert/update/delete products (For now, maybe allow authenticated for demo?)
-- For this task, we assume products are managed by admin, but we might need to seed data.
-- Let's allow authenticated users to insert for demo purposes if needed, or just rely on seed.
-- We will stick to read-only for public/authenticated for now.

-- Product Orders Policies
-- Users can view their own orders
CREATE POLICY "Users can view own orders"
    ON public.product_orders FOR SELECT
    USING (auth.uid() = user_id);

-- Users can create their own orders
CREATE POLICY "Users can create own orders"
    ON public.product_orders FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- ============================================================================
-- 5. SEED DATA (Optional, for demo)
-- ============================================================================
INSERT INTO public.products (title, description, price, category, image_url, stock)
VALUES
    ('有机草莓', '新鲜采摘的有机草莓，甜度高，口感好。', 35.00, 'agricultural', 'https://picsum.photos/seed/strawberry/400/400', 100),
    ('散养土鸡蛋', '农家散养土鸡下的蛋，营养丰富。', 2.50, 'poultry', 'https://picsum.photos/seed/eggs/400/400', 500),
    ('多肉植物组合', '精选多肉植物，办公桌摆件首选。', 18.00, 'plants', 'https://picsum.photos/seed/succulent/400/400', 50),
    ('手工竹编篮', '传统工艺制作，环保耐用。', 45.00, 'cultural', 'https://picsum.photos/seed/basket/400/400', 20),
    ('新鲜时蔬礼包', '当季新鲜蔬菜组合，健康美味。', 28.00, 'agricultural', 'https://picsum.photos/seed/vegetables/400/400', 30),
    ('走地鸡', '山林放养走地鸡，肉质紧实。', 128.00, 'poultry', 'https://picsum.photos/seed/chicken/400/400', 10);

-- Grant permissions
GRANT SELECT ON public.products TO anon, authenticated;
GRANT SELECT, INSERT ON public.product_orders TO authenticated;
