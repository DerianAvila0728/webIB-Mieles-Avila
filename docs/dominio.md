# Nuestro negocio

Negocio: Plataforma digital de gestión de entrenamiento físico, rutinas de hipertrofia/cardio y planes de nutrición personalizados para atletas.


## Las dos entidades
1. Rutinas / Planes (planes de ejercicios y dietas asignados).
2. Clientes / Atletas (usuarios que reciben y ejecutan dichos planes).
Que se relaciona con la primera porque cada cliente tiene asignada una rutina o plan nutricional específico según su nivel y objetivo.

## La entidad que cambia de estado
Entidad: Rutina / Plan
Estados: 
Pendiente -> En progreso -> Completado
Quien provoca cada cambio: El entrenador actualiza el estado según el avance del atleta, o el sistema lo marca al finalizar el ciclo.

## Los dos roles
- Entrenador: Puede crear rutinas, asignar dietas, modificar estados y supervisar atletas; no puede eliminar cuentas maestras del sistema.
- Cliente / Atleta: Puede visualizar su plan asignado, ver su progreso y marcar sesiones como realizadas; no puede modificar rutinas de otros usuarios.

## La pantalla de hoy
El rol que la usa: Entrenador de gimnasio.
La pregunta que responde: ¿Qué planes y rutinas tengo asignados hoy y en qué estado se encuentran?

## Pendientes
- Semana 3: Definir notificaciones automáticas para los clientes cuando el plan cambie de estado.