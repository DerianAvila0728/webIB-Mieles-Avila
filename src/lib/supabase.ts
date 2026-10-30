// src/lib/supabaseClient.ts (o la ruta que estés usando en tus imports)
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://aqiwzhspancaxhvxlkuj.supabase.co' 
const supabaseKey = 'sb_publishable_6EcKknEhJsI9YB3beA1Xxw_WxK1Ec90' // Pega aquí tu clave anon real

export const supabase = createClient(supabaseUrl, supabaseKey)