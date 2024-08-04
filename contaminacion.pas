PROGRAM contaminacion;
USES crt;

TYPE
    mediciones,maestro = RECORD
     fecha_hora: string[8];
     nro_zona: integer;
     snap: real;
    END;

    zonas = RECORD
     descripcion: string[30];
    END;

VAR
   archivo_mediciones,archivo_maestro: FILE OF mediciones;
   archivo_zonas: FILE OF zonas;
   registro_mediciones,registro_maestro: mediciones;
   registro_zonas: zonas;
   tot: array[1..15,1..3]of integer;

PROCEDURE crea_archivo_mediciones;
 BEGIN
 rewrite(archivo_mediciones);
 close(archivo_mediciones);
 END;

PROCEDURE crea_archivo_maestro;
 BEGIN
 rewrite(archivo_maestro);
 close(archivo_maestro);
 END;

PROCEDURE crea_archivo_zonas;
 BEGIN
 rewrite(archivo_zonas);
 close(archivo_zonas);
 END;

PROCEDURE carga_archivo_mediciones;
VAR
 op: string;
   BEGIN
   REPEAT
    clrscr;
    reset(archivo_mediciones);
    write('Ingrese fecha y hora: ');
    readln(registro_mediciones.fecha_hora);
    writeln();
    registro_mediciones.nro_zona:= valida_zona;
    writeln();
    write('Ingrese snap: ');
    readln(registro_mediciones.snap);
    seek(archivo_mediciones,filesize(archivo_mediciones));
    write(archivo_mediciones,registro_mediciones);
    writeln();
    writeln('REGISTRO GUARDADO');
    writeln();
    write('Desea agregar otro registro[s/n]?: ');
    REPEAT
    readln(op);
    UNTIL (op = 's') OR (op = 'n');
    UNTIL (op = 'n');
   END;

PROCEDURE menu_principal;
VAR
 op: integer;
 BEGIN
 REPEAT
 clrscr;
 writeln('1. Cargar archivo mediciones');
 writeln('2. Cargar archivo maestro');
 writeln('3. Cargar archivo_zonas');
 writeln('4. Informe diario');
 writeln('5. Generar maestro');
 writeln('6. Limpiar tarjeta');
 writeln('7. Salir');
 writeln();
 write('Seleccione opcion: ');
 REPEAT
 readln(op);
 UNTIL (op >= 1) AND (op <= 7);
 CASE op OF
  1:BEGIN
    carga_archivo_mediciones;
    END;
 { 2:BEGIN
    genera_maestro;
    END;
  3:BEGIN
    limpiar_tarjeta;
    END;
  4:BEGIN
    END;
  5:BEGIN
    END;
  6:BEGIN
    END;}
 END;
 UNTIL (op = 7);
 close(archivo_mediciones);
 close(archivo_maestro);
 close(archivo_zonas);
 END;


BEGIN
assign(archivo_mediciones,'C:\Users\JULIO\Desktop\final-contaminacion\mediciones.dat');
assign(archivo_maestro,'C:\Users\JULIO\Desktop\final-contaminacion\maestro.dat');
assign(archivo_zonas,'C:\Users\JULIO\Desktop\final-contaminacion\zonas.dat');
crea_archivo_mediciones;
crea_archivo_maestro;
crea_archivo_zonas;
menu_principal;
END.
