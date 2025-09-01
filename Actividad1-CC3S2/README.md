## Introducción devops, devsecops

FECHA: 31/08/2025
Tiempo total invertido: 04:13

### Dia 1

#### 4.1 DevOps vs cascada tradicional (investigación + comparación)

-Agrega una imagen comparativa en imagenes/devops-vs-cascada.png. Puede ser un diagrama propio sencillo.

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/devops-vs-cascada.png" width="500"/>

Explica por qué DevOps acelera y reduce riesgo en software para la nube frente a cascada (feedback continuo, pequeños lotes, automatización).

Para el modelo tradicional de cascada, el desarrollo se hace por fases sin retroalimentacion temprana. Esto genera ciclos largos, rigidez debido a los cambios y tambien grandes lotes de despliegue donde demora en descubrir errores. Por otro lado DevOps impulsa estos cambios pequeños y frecuentes mediante integracion y entrega continua (CI y CD), automatizacion y feedback constante. Esto acelera la deteccion de fallos y reduce el riesgo de despliegues en la nube.

-Pregunta retadora: señala un contexto real donde un enfoque cercano a cascada sigue siendo razonable (por ejemplo, sistemas con certificaciones regulatorias estrictas o fuerte acoplamiento hardware). Expón dos criterios verificables y los trade-offs (velocidad vs. conformidad/seguridad).

Un  contexto cercano a cascada es en los sistemas regulados o hardware cerrado (como los dispositivos médicos o control industrial muy utilizados en estos tiempos) donde los ciclos de certificación tardan meses y el hardware no permite iteraciones rápidas. Ademas, dos criterios verificables serían: el tiempo estándar de validación regulatoria (aprox 6 meses) y la dependencia de pruebas físicas con hardware, no reproducibles en entornos digitales. Finalmente el trade-off seria: velocidad versus conformidad y seguridad.

#### 4.2 Ciclo tradicional de dos pasos y silos (limitaciones y anti-patrones).

-Inserta una imagen de silos organizacionales en imagenes/silos-equipos.png (o un dibujo propio).

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/silos-equipos.png" width="500"/>

-Identifica dos limitaciones del ciclo "construcción -> operación" sin integración continua (por ejemplo, grandes lotes, colas de defectos).

Cuando el ciclo se limita a construcción y operación sin integración continua, enfrentamos dos limitaciones críticas. Una de ellas son los cambios en grandes lotes que acumulan errores y los cuellos de botella por falta de pruebas tempranas, y el otro es la coherencia de información entre ambos equipos, lo que genera disputas y culpas entre desarrolladores y operaciones.

-Pregunta retadora: define dos anti-patrones ("throw over the wall", seguridad como auditoría tardía) y explica cómo agravan incidentes (mayor MTTR, retrabajos, degradaciones repetitivas).

Dos antipatrones comunes que agravan es el throw over the wall, donde los desarrolladores lanzan código sin contexto al equipo de operaciones y el otro es el enfoque de seguridad como auditoría tardía, donde los problemas de seguridad se detectan al final del ciclo. Ambos elevan el tiempo medio de recuperación, aumentan el retrabajo y provocan degradaciones repetitivas

#### 4.3 Principios y beneficios de DevOps (CI/CD, automatización, colaboración; Agile como precursor)

-Describe CI y CD destacando tamaño de cambios, pruebas automatizadas cercanas al código y colaboración.

DevOps se basa en CI porque integra cambios pequeños varias veces al día y tambien se basa en CD porque despliega automáticamente tras pasar pruebas ligeras. Esto hace que mejore la calidad del software, reducir errores manuales y permite respuestas más ágiles ante fallos.

-Explica cómo una práctica Agile (reuniones diarias, retrospectivas) alimenta decisiones del pipeline (qué se promueve, qué se bloquea).

Las prácticas ágiles como las reuniones diarias y retrospectivas ayudan a decidir qué PRs o versiones fomentar y cuáles detener como por ejemplo si un cambio causó conflicto, se bloquea su despliegue o si otro fue bien recibido, se acelera su paso por el pipeline.

-Propón un indicador observable (no financiero) para medir mejora de colaboración Dev-Ops (por ejemplo, tiempo desde PR listo hasta despliegue en entorno de pruebas; proporción de rollbacks sin downtime).

Un indicador observable no financiero podría ser el tiempo promedio entre PR listo y despliegue en entorno de pruebas. Estos se pueden medir usando los timestamps de los PRs y los registros de despliegue, con scripts.

### Dia 2

#### 4.4 Evolución a DevSecOps (seguridad desde el inicio: SAST/DAST; cambio cultural)

-Diferencia SAST (estático, temprano) y DAST (dinámico, en ejecución), y ubícalos en el pipeline.

En DevOps tradicional, la seguridad suele llegar tarde como auditoría final, pero en DevSecOps se integra desde el arranque del pipeline. Por ejemplo, SAST revisa el código antes de compilar, detectando vulnerabilidades en dependencias o malas prácticas de programación. En cambio, DAST se corre cuando la aplicación ya está desplegada en un entorno de pruebas, simulando ataques reales en ejecución. Lo ideal es colocar SAST en la fase de build y DAST en staging/preproducción.

-Define un gate mínimo de seguridad con dos umbrales cuantitativos (por ejemplo, "cualquier hallazgo crítico en componentes expuestos bloquea la promoción"; "cobertura mínima de pruebas de seguridad del X%").

Un gate mínimo de seguridad podría ser bloquear cualquier hallazgo crítico en servicios expuestos y exigir al menos 80% de cobertura en pruebas de seguridad automatizadas antes de promover.

-Incluye una política de excepción con caducidad, responsable y plan de corrección.

Si existe una excepción, debe tener fecha de caducidad (como por ejemplo 30 días), un responsable designado y un plan de corrección documentado, de forma que no se convierta en deuda infinita.

-Pregunta retadora: ¿cómo evitar el "teatro de seguridad" (cumplir checklist sin reducir riesgo)? Propón dos señales de eficacia (disminución de hallazgos repetidos; reducción en tiempo de remediación) y cómo medirlas.
Validación: que los umbrales sean concretos y la excepción tenga fecha límite y dueño.

1) Menos hallazgos repetidos en cada ciclo osea lo puedes medir comparando reportes de SAST/DAST mes a mes.
2) Menor tiempo de remediación que se puede observar midiendo desde que se abre un issue hasta que se corrige y despliega.


#### 4.5 CI/CD y estrategias de despliegue (sandbox, canary, azul/verde)

-Inserta una imagen del pipeline o canary en imagenes/pipeline_canary.png.

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/pipeline_canary.png" width="500"/>

-Elige una estrategia para un microservicio crítico (por ejemplo, autenticación) y justifica.

En un pipeline moderno puedes usar distintas estrategias de despliegue para reducir riesgo. Por ejemplo para un microservicio crítico como autenticación, una estrategia canary release es muy razonable: primero expones la nueva versión a un porcentaje pequeño de usuarios, y solo si las métricas técnicas se mantienen dentro de umbral, se expande al resto.

-Crea una tabla breve de riesgos vs. mitigaciones (al menos tres filas), por ejemplo:
Regresión funcional -> validación de contrato antes de promover.
Costo operativo del doble despliegue -> límites de tiempo de convivencia.
Manejo de sesiones -> "draining" y compatibilidad de esquemas.
Define un KPI primario (p. ej., error 5xx, latencia p95) y un umbral numérico con ventana de observación para promoción/abortado.

| Riesgo                              | Mitigación                                                             |
| ----------------------------------- | ---------------------------------------------------------------------- |
| Regresión funcional                 | Validación de contrato y pruebas de integración antes de promover      |
| Costo operativo de doble despliegue | Límites de tiempo para convivencia de versiones                        |
| Manejo de sesiones activas          | Draining de conexiones y compatibilidad en esquemas de base de datos   |

Pregunta retadora: si el KPI técnico se mantiene, pero cae una métrica de producto (conversión), explica por qué ambos tipos de métricas deben coexistir en el gate.

El KPI primario podría ser la tasa de errores como 5xx < 1% durante una ventana de observación de 15 minutos. Donde si el canary se mantiene bajo ese umbral, se promueve; si no, rollback inmediato.


### Dia 3

#### 4.6 Fundamentos prácticos sin comandos 

Realiza comprobaciones con herramientas estándar, pero no pegues los comandos. En el README escribe los hallazgos y la interpretación. Adjunta tus capturas en imagenes/ y marca los campos relevantes (códigos, cabeceras, TTL, CN/SAN, fechas, puertos).

1) HTTP - contrato observable

-Reporta: método, código de estado y dos cabeceras clave (por ejemplo, una de control de caché y otra de traza/diagnóstico).

La comprobación HTTP se realizó sobre un endpoint accesible vía GET. El método usado fue GET, el código de estado devuelto fue 200 OK y se destacaron dos cabeceras que fuero cache-control y X Amzn Trace Id.

-Explica por qué esas cabeceras influyen en rendimiento, caché u observabilidad.

La cabecera Cache-Control impacta directamente en el rendimiento porque define cuánto tiempo las respuestas pueden almacenarse en caché, reduciendo la carga en el servidor. Por otro lado, X Amzn Trace Id es clave para la trazabilidad, ya que permite seguir una petición a lo largo de distintos servicios, aportando observabilidad para depuración o diagnóstico.

-Captura: imagenes/http-evidencia.png, con los campos resaltados.

<h3>Evidencia: Solicitud HTTP</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/http-evidencia.png" width="500"/>

<h3>Evidencia 1: Logs y validación</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/evidencia1.png" width="500"/>


2) DNS - nombres y TTL

-Reporta: tipo de registro (A o CNAME) y TTL de un dominio.

En la consulta DNS de example.com se observaron registros tipo A, asociados a varias direcciones IP. El TTL obtenido fue de aproximadamente 4 minutos y 18 segundos.

-Explica cómo el TTL afecta rollbacks y cambios de IP (propagación, ventanas de inconsistencia).

Este valor indica cuánto tiempo los clientes y resolvers pueden mantener en caché esa información antes de volver a consultarla. Un TTL más alto mejora el rendimiento y reduce carga en los servidores, pero al mismo tiempo hace más lentos los cambios de IP o rollbacks.

-Captura: imagenes/dns-ttl.png, con el TTL destacado.

<h3>Evidencia DNS: TTL Configurado</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/dns-ttl.png" width="500"/>

<h3>Evidencia DNS (parte 2): TTL Detallado</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/dns-ttl1.png" width="500"/>


3) TLS - seguridad en tránsito

-Reporta: CN/SAN, vigencia (desde/hasta) y emisora del certificado de un sitio seguro.

En la inspección TLS de un sitio seguro se identificaron los campos principales del certificado: el CN/SAN, la vigencia y la emisora.

-Explica qué sucede si no valida la cadena (errores de confianza, riesgo de MITM, impacto en UX).

Si la cadena del certificado no es válida o el certificado está caducado, los navegadores muestran errores de confianza, lo que no solo genera una mala experiencia de usuario, sino que además expone al riesgo de ataques tipo MITM, donde un atacante podría interceptar o modificar la comunicación.


-Captura: imagenes/tls-cert.png, con CN/SAN, emisora y fechas.

<h3>Evidencia TLS: Certificado Válido</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/tls-cert.png" width="500"/>

4) Puertos - estado de runtime

-Enumera dos puertos en escucha en tu máquina o entorno y qué servicios sugieren.

Durante la exploración de servicios en ejecución se detectaron al menos dos puertos en escucha, por ejemplo: 80 (HTTP) y 443 (HTTPS). Estos sugieren que el sistema está sirviendo tráfico web tanto en texto plano como encriptado.

-Explica cómo esta evidencia ayuda a detectar despliegues incompletos (puerto no expuesto) o conflictos (puerto ocupado).

Verificar qué puertos están activos ayuda a identificar despliegues incompletos (si un puerto esperado no está expuesto, puede significar que el servicio no levantó correctamente) o conflictos de configuración (si otro proceso ocupa el puerto requerido por la aplicación).

-Captura: imagenes/puertos.png, con los puertos resaltados.


<h3>Evidencia: Puertos Expuestos</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/puertos.png" width="500"/>

5) 12-Factor - port binding, configuración, logs

-Describe cómo parametrizarías el puerto sin tocar código (config externa).

El puerto de la aplicación se debería parametrizar mediante las variables de entorno sin modificar el código fuente.

-Indica dónde verías los logs en ejecución (flujo estándar) y por qué no deberías escribirlos en archivos locales rotados a mano.

Los logs se deberían visualizar por flujo estándar y centralizar en un sistema de monitoreo, en lugar de escribirlos en archivos locales rotados manualmente, lo cual complica la trazabilidad.

-Señala un anti-patrón (p. ej., credenciales en el código) y su impacto en reproducibilidad.

Un ejemplo de anti-patrón es incluir credenciales directamente en el código. Esto afecta la reproducibilidad y seguridad, ya que obliga a cambios en el código para modificar credenciales y expone secretos en repositorios o despliegues.

6)Checklist de diagnóstico (incidente simulado)

-Escenario: usuarios reportan intermitencia. Formula un checklist de seis pasos ordenados que permita discriminar: a) contrato HTTP roto, b) resolución DNS inconsistente, c) certificado TLS caducado/incorrecto, d) puerto mal configurado/no expuesto. Para cada paso, indica: objetivo, evidencia esperada, interpretación y acción siguiente. Evita generalidades; sé operacional (si X ocurre, entonces Y decisión).

Checklist incidente (usuarios reportan intermitencia)

1) Verificar contrato HTTP
   - Objetivo: confirmar que el endpoint responde correctamente.
   - Evidencia esperada: código HTTP y cabeceras (captura http-evidencia.png).
   - Si status = 5xx sostenido → acción: rollback inmediato. Si 4xx inesperado - revisar reglas/ACL.
2) Comprobar resolución DNS
   - Objetivo: confirmar que nombre resuelve a la IP esperada y TTL.
   - Evidencia esperada: captura dns-ttl.png.
   - Si IP difiere y TTL alto → acción: considerar propagación; si es error de zona, arreglar DNS y notificar ventana de propagación.
3) Validar certificado TLS
   - Objetivo: comprobar CN/SAN y vigencia.
   - Evidencia esperada: tls-cert.png.
   - Si caducado o SAN erróneo → acción: renovar/reconfigurar y no promover.
4) Revisar puertos y procesos
   - Objetivo: confirmar que el servicio escucha en el puerto correcto.
   - Evidencia esperada: puertos.png.
   - Si puerto ausente → acción: reiniciar servicio y revisar logs; si ocupado → liberar o cambiar binding.
5) Consultar logs (stdout)
   - Objetivo: identificar errores repetidos o stack traces.
   - Evidencia esperada: captura parcial de logs correlacionada con X-Request-Id.
   - Si errores repetidos → acción: bloquear promoción y abrir issue con trazas.
6) Verificar KPIs de salud (ventana observación 15 min)
   - Objetivo: comprobar tasa de errores 5xx y latencia p95.
   - Evidencia esperada: métricas (console/monitor). Umbral: errores 5xx ≤ 0.1% en 15 min y p95 latencia ≤ [tu umbral ms].
   - Si fuera de umbral → acción: rollback y análisis de causa raíz.


#### 4.7 Desafíos de DevOps y mitigaciones

-Inserta un diagrama propio o ilustración en imagenes/desafios_devops.png con tres desafíos anotados (culturales, técnicos, de gobernanza).

Desafios:
Cultural: Resistencia al cambio y falta de colaboración:
Equipos de desarrollo, operaciones y QA a menudo trabajan en silos. Implementar DevOps requiere cambiar mentalidades y fomentar la colaboración.

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/desafios_devops1.jpg" width="300"/>

Desafío técnico: Integración y automatización de herramientas:
Integrar múltiples herramientas de CI/CD, monitoreo, testing, etc., de forma coherente y automatizada.

<h3>Desafíos de DevOps</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/desafios_devops.jpg" width="400"/>

Desafío de gobernanza: Seguridad y cumplimiento normativo
Asegurar que los procesos DevOps cumplan con regulaciones (como GDPR, HIPAA) sin frenar la velocidad de entrega.

<h3>Desafíos de DevOps</h3>
<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/desafios_devops2.png" width="500"/>

-Enumera tres riesgos con su mitigación concreta (rollback, despliegues graduales, revisión cruzada, límites de "blast radius").

Los principales riesgos en un despliegue incluyen fallos críticos que obliguen a un rollback, errores parciales mitigados con despliegues graduales, y problemas de coordinación prevenidos con revisión cruzada y límites de “blast radius”.

-Diseña un experimento controlado para validar que el despliegue gradual reduce riesgo frente a uno "big-bang": define métrica primaria, grupo control, criterio de éxito y plan de reversión.

Un experimento controlado para validar despliegues graduales consistiría en comparar un grupo con despliegue big-bang frente a otro con despliegue progresivo, midiendo como métrica principal la tasa de errores en producción. El criterio de éxito sería demostrar menor impacto en el grupo gradual, con un plan de reversión inmediato si la tasa excede un umbral definido.


#### 4.8 Arquitectura mínima para DevSecOps (HTTP/DNS/TLS + 12-Factor)

-Dibuja un diagrama propio en imagenes/arquitectura-minima.png con el flujo: Cliente -> DNS -> Servicio (HTTP) -> TLS, e indica dónde aplicar controles (políticas de caché, validación de certificados, contratos de API, límites de tasa).

![](https://raw.githubusercontent.com/AriusJoel1/Desarrollo-De-Software/main/Actividad1-CC3S2/imagenes/arquitectura-minima.png)

-Explica cómo cada capa contribuye a despliegues seguros y reproducibles.

La arquitectura mínima de DevSecOps integra Cliente, DNS, Servicio, TLS. En cada capa se aplican controles como caché segura en DNS, validación de certificados en TLS, contratos de API en HTTP y límites de tasa en el servicio. Esto asegura despliegues confiables y reproducibles.

-Relaciona dos principios 12-Factor (config por entorno; logs a stdout) con evidencias operativas que un docente podría revisar (por ejemplo, diffs mínimos entre entornos, trazabilidad de logs).

Los principios 12-Factor se aplican en la configuración por entorno, garantizando cambios mínimos entre dev, test y prod, y en el manejo de logs a stdout, que permiten trazabilidad uniforme que cualquier docente puede auditar.
