# Products Feature

## Overview
The Products feature allows users to browse agricultural products, view details, and place orders.

## Features
- **Product Feed**: Displays a list of products with category filtering.
- **Category Filter**: Filter products by categories (Agricultural, Poultry, Plants, Cultural).
- **Product Detail**: View detailed information about a product (image, price, description, stock).
- **Ordering**: Authenticated users can place orders. Unauthenticated users are redirected to login.

## Architecture

### Data Layer
- **Supabase Tables**:
  - `products`: Stores product information.
  - `product_orders`: Stores order records.
- **Models**:
  - `Product`: Freezed model for product data.
  - `ProductOrder`: Freezed model for order data.
- **Repository**:
  - `ProductRepository`: Handles data fetching and order creation via Supabase.

### State Management (Riverpod)
- **ProductViewModel**: Manages the list of products, supports category filtering.
- **ProductDetailViewModel**: Manages the state of a single product.
- **OrderViewModel**: Manages the order creation process.

### UI
- **HomeScreen**: Main entry point, displays the product feed and category filter.
- **ProductDetailScreen**: Displays product details and the "Order Now" button.

## Database Schema

### Products Table
```sql
create table public.products (
  id uuid not null default gen_random_uuid (),
  created_at timestamp with time zone not null default now(),
  title text not null,
  description text null,
  price double precision not null,
  image_url text null,
  category text not null, -- 'agricultural', 'poultry', 'plants', 'cultural'
  stock integer not null default 0,
  is_active boolean not null default true,
  constraint products_pkey primary key (id)
);
```

### Product Orders Table
```sql
create table public.product_orders (
  id uuid not null default gen_random_uuid (),
  created_at timestamp with time zone not null default now(),
  user_id uuid not null,
  product_id uuid not null,
  quantity integer not null default 1,
  total_price double precision not null,
  status text not null default 'pending', -- 'pending', 'paid', 'shipped', 'completed', 'cancelled'
  constraint product_orders_pkey primary key (id),
  constraint product_orders_product_id_fkey foreign key (product_id) references products (id),
  constraint product_orders_user_id_fkey foreign key (user_id) references auth.users (id)
);
```

## Security (RLS)
- **Products**: Publicly readable. Only admins can insert/update/delete (policy not fully enforced in migration yet, but RLS is enabled).
- **Product Orders**: Users can insert their own orders and view their own orders.

## Future Improvements
- Search functionality.
- Cart system.
- Payment integration.
- Order history view.
