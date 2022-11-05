CALL CrearCarrera('Arquitectura');
select * from carreras;
CALL RegistrarEstudiante(201901315, 'Daniel', 'Soto Cardona', '2001-01-03', 'maquito@gmail.com', 78945262, 'Ciudad', 3006137170404, 22);
select * from estudiantes;
CALL RegistrarDocente('Daphne Michelle', 'Cu Lemus', '1996-03-01', 'daphne@yahoo.com', 42455873, 'Ciudad', 3006137123423, 2);
select * from docentes;
CALL CrearCurso(31, 'Meca V', 100, 10, true, 28);
select * from cursos;
CALL HabilitarCurso(12, 'VD', 2, 2, 'a');
select * from cursos_habilitados;
CALL AsignarCurso(1, 'VD', 'a', 201901315);
CALL DesasignarCurso(1, '1S', 'a', 951987482);
select * from asignaciones;
CALL IngresarNota(1, '1S', 'b', 951987482, 55);
select * from asignaciones;
SET SQL_SAFE_UPDATES = 0;
CALL GenerarActa(1, '1S', 'a');
select * from cursos_habilitados;

CALL AgregarTransaccion(NOW(), 'Prueba', 'INSERT');
select * from transacciones;


select * from actas;
-- CONSULTAS
CALL ConsultarPensum(22);
CALL ConsultarEstudiante(201901416);
CALL ConsultarDocente(2);
CALL ConsultarAsignados(1, '1S', 2022, 'A');
CALL ConsultarAprobaciones(1, '1S', 2022, 'B');
CALL ConsultarActas(1);
CALL ConsultarDesasignacion(1, '1S', 2022, 'A');