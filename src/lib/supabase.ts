import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://aqiwzhspancaxhvxlkuj.supabase.co'
const supabaseKey = 'sb_publishable_6EcKknEhJsI9YB3beA1Xxw_WxK1Ec90'

export const supabase = createClient(supabaseUrl, supabaseKey)