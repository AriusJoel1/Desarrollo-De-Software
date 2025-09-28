## Actividad 6: Introducción a Git conceptos básicos y operaciones esenciales

**Configuración inicial:**
Se creo una estructura inicial y se configuró el nombre y correo de usuario para asociar los commits

![alt text](img/image.png)

**Inicialización del repositorio**
Se omitio la inicializacion y verificacion del repositorio debido a que ya hay un repositorio.

**Commits iniciales**
Realizamos los primeros commits para el readme, contributing y main

![alt text](img/image-1.png)

Revisamos el historial de commits usando con log, creamos una rama y nos movemos a ella

![alt text](img/image-2.png)


**Conflictos y resolucion de conflictos**
Modificamos el main dentro de la rama y realizamos un merge para generar un conflicto

![alt text](img/image-3.png)

Ya hemos producido un conflicto en main.py y lo resolvimos manualmente editando el archivo y confirmando el merge.

![alt text](img/image-4.png)

![alt text](img/image-5.png)

**Logs guardados**
Revisamos el historial para ver cómo se ha integrado el commit

![alt text](img/image-6.png)

**Trabajo colaborativo y manejo de Pull Requests y abrir un pull request**

Creamos un nuevo repositorio remoto, lo clonamos y creamos una nueva rama
Luego realizamos cambios y creamos un pull request para realizar el merge

![alt text](img/image-7.png)

finalmente aceptamos el PR

![alt text](img/image-8.png)

finalmente eliminamos la rama remota y local con:
![alt text](img/image-9.png)
![alt text](img/image-10.png)

**Cherry-Picking y Git Stash**
Hacemos cambios en main.py y confirmarlos:

![alt text](img/image-11.png)

Aplicamos el commit específico y guardamos los cambios noc onfirmados

![alt text](img/image-12.png)
![alt text](img/image-13.png)