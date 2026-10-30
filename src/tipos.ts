export type EstadoSuscripcion = 'Pendiente' | 'Activa' | 'Vencida';

export interface Usuario {
  id: number;
  nombre: string;
  rol: string;
}

export interface Plan {
  id: number;
  precio: number;
  dias: number;
}

export interface Suscripcion {
  id: number;
  usuario_id: number; // Relación con Usuario
  plan_id: number;    // Relación con Plan
  estado: EstadoSuscripcion;
  fin: string;
}

export interface Pago {
  id: number;
  suscripcion_id: number; // Relación con Suscripción
  monto: number;
  foto_url: string;
}

export interface Asistencia {
  id: number;
  suscripcion_id: number; // Relación con Suscripción
  ingreso: string;
  nota: string;
}