// src/lib/supabaseClient.ts (o la ruta que estés usando en tus imports)
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://aqiwzhspancaxhvxlkuj.supabase.co' 
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFxaXd6aHNwYW5jYXhodnhsa3VqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMzMjAwNzEsImV4cCI6MjEwODg5NjA3MX0.SF4N2tWLpiiCP8f2-HCqZYzgGu_AFxXFF0uQ9sE2fE4' // Pega aquí tu clave anon real

export const supabase = createClient(supabaseUrl, supabaseKey)