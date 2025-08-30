## Introducción devops, devsecops

FECHA: 30/08/2025  
Tiempo total invertido: 03:11  

### Dia 1
#### DevOps vs cascada tradicional 

- Agrega una imagen comparativa en imagenes/devops-vs-cascada.png. Puede ser un diagrama propio sencillo.

## imagenes/devops-vs-cascada.png

- Explica por qué DevOps acelera y reduce riesgo en software para la nube frente a cascada (feedback continuo, pequeños lotes, automatización).

Para el modelo tradicional de cascada, el desarrollo se hace por fases sin retroalimentacion temprana. Esto genera ciclos largos, rigidez debido a los cambios y tambien grandes lotes de despliegue donde demora en descubrir errores. Por otro lado DevOps impulsa estos cambios pequeños y frecuentes mediante integracion y entrega continua (CI y CD), automatizacion y feedback constante. Esto acelera la deteccion de fallos y reduce el riesgo de despliegues en la nube.

- Pregunta retadora: señala un contexto real donde un enfoque cercano a cascada sigue siendo razonable (por ejemplo, sistemas con certificaciones regulatorias estrictas o fuerte acoplamiento hardware). Expón dos criterios verificables y los trade-offs (velocidad vs. conformidad/seguridad).

Un  contexto cercano a cascada es en los sistemas regulados o hardware cerrado (como los dispositivos médicos o control industrial muy utilizados en estos tiempos) donde los ciclos de certificación tardan meses y el hardware no permite iteraciones rápidas. Ademas, dos criterios verificables serían: el tiempo estándar de validación regulatoria (aprox 6 meses) y la dependencia de pruebas físicas con hardware, no reproducibles en entornos digitales. Finalmente el trade-off seria: velocidad versus conformidad y seguridad.

#### 4.2 Ciclo tradicional de dos pasos y silos (limitaciones y anti-patrones).

- Inserta una imagen de silos organizacionales en imagenes/silos-equipos.png (o un dibujo propio).

## silos.equipos.png

- Identifica dos limitaciones del ciclo "construcción -> operación" sin integración continua (por ejemplo, grandes lotes, colas de defectos).

Cuando el ciclo se limita a construcción y operación sin integración continua, enfrentamos dos limitaciones críticas. Una de ellas son los cambios en grandes lotes que acumulan errores y los cuellos de botella por falta de pruebas tempranas, y el otro es la coherencia de información entre ambos equipos, lo que genera disputas y culpas entre desarrolladores y operaciones.

- Pregunta retadora: define dos anti-patrones ("throw over the wall", seguridad como auditoría tardía) y explica cómo agravan incidentes (mayor MTTR, retrabajos, degradaciones repetitivas).

Dos antipatrones comunes que agravan es el throw over the wall, donde los desarrolladores lanzan código sin contexto al equipo de operaciones y el otro es el enfoque de seguridad como auditoría tardía, donde los problemas de seguridad se detectan al final del ciclo. Ambos elevan el tiempo medio de recuperación, aumentan el retrabajo y provocan degradaciones repetitivas

#### 4.3 Principios y beneficios de DevOps (CI/CD, automatización, colaboración; Agile como precursor)

- Describe CI y CD destacando tamaño de cambios, pruebas automatizadas cercanas al código y colaboración.

DevOps se basa en CI porque integra cambios pequeños varias veces al día y tambien se basa en CD porque despliega automáticamente tras pasar pruebas ligeras. Esto hace que mejore la calidad del software, reducir errores manuales y permite respuestas más ágiles ante fallos.

- Explica cómo una práctica Agile (reuniones diarias, retrospectivas) alimenta decisiones del pipeline (qué se promueve, qué se bloquea).

Las prácticas ágiles como las reuniones diarias y retrospectivas ayudan a decidir qué PRs o versiones fomentar y cuáles detener como por ejemplo si un cambio causó conflicto, se bloquea su despliegue o si otro fue bien recibido, se acelera su paso por el pipeline.

- Propón un indicador observable (no financiero) para medir mejora de colaboración Dev-Ops (por ejemplo, tiempo desde PR listo hasta despliegue en entorno de pruebas; proporción de rollbacks sin downtime).

Un indicador observable no financiero podría ser el tiempo promedio entre PR listo y despliegue en entorno de pruebas. Estos se pueden medir usando los timestamps de los PRs y los registros de despliegue, con scripts.



### Dia 2

#### 4.4 Evolución a DevSecOps (seguridad desde el inicio: SAST/DAST; cambio cultural)

- Diferencia SAST (estático, temprano) y DAST (dinámico, en ejecución), y ubícalos en el pipeline.

En DevOps tradicional, la seguridad suele llegar tarde como auditoría final, pero en DevSecOps se integra desde el arranque del pipeline. Por ejemplo, SAST revisa el código antes de compilar, detectando vulnerabilidades en dependencias o malas prácticas de programación. En cambio, DAST se corre cuando la aplicación ya está desplegada en un entorno de pruebas, simulando ataques reales en ejecución. Lo ideal es colocar SAST en la fase de build y DAST en staging/preproducción.

- Define un gate mínimo de seguridad con dos umbrales cuantitativos (por ejemplo, "cualquier hallazgo crítico en componentes expuestos bloquea la promoción"; "cobertura mínima de pruebas de seguridad del X%").

Un gate mínimo de seguridad podría ser bloquear cualquier hallazgo crítico en servicios expuestos y exigir al menos 80% de cobertura en pruebas de seguridad automatizadas antes de promover.

- Incluye una política de excepción con caducidad, responsable y plan de corrección.

Si existe una excepción, debe tener fecha de caducidad (como por ejemplo 30 días), un responsable designado y un plan de corrección documentado, de forma que no se convierta en deuda infinita.

- Pregunta retadora: ¿cómo evitar el "teatro de seguridad" (cumplir checklist sin reducir riesgo)? Propón dos señales de eficacia (disminución de hallazgos repetidos; reducción en tiempo de remediación) y cómo medirlas.  
Validación: que los umbrales sean concretos y la excepción tenga fecha límite y dueño.

1) Menos hallazgos repetidos en cada ciclo osea lo puedes medir comparando reportes de SAST/DAST mes a mes.  
2) Menor tiempo de remediación que se puede observar midiendo desde que se abre un issue hasta que se corrige y despliega.

#### 4.5 CI/CD y estrategias de despliegue (sandbox, canary, azul/verde)

- Inserta una imagen del pipeline o canary en imagenes/pipeline_canary.png.

## pipeline_canary

- Elige una estrategia para un microservicio crítico (por ejemplo, autenticación) y justifica.

En un pipeline moderno puedes usar distintas estrategias de despliegue para reducir riesgo. Por ejemplo para un microservicio crítico como autenticación, una estrategia canary release es muy razonable: primero expones la nueva versión a un porcentaje pequeño de usuarios, y solo si las métricas técnicas se mantienen dentro de umbral, se expande al resto.

- Crea una tabla breve de riesgos vs. mitigaciones (al menos tres filas), por ejemplo:  
Regresión funcional -> validación de contrato antes de promover.  
Costo operativo del doble despliegue -> límites de tiempo de convivencia.  
Manejo de sesiones -> "draining" y compatibilidad de esquemas.  
Define un KPI primario (p. ej., error 5xx, latencia p95) y un umbral numérico con ventana de observación para promoción/abortado.

| Riesgo                              | Mitigación                                                             |
| ----------------------------------- | ---------------------------------------------------------------------- |
| Regresión funcional                 | Validación de contrato y pruebas de integración antes de promover      |
| Costo operativo de doble despliegue | Límites de tiempo para convivencia de versiones                        |
| Manejo de sesiones activas          | Draining de conexiones y compatibilidad en esquemas de base de datos   |

- Pregunta retadora: si el KPI técnico se mantiene, pero cae una métrica de producto (conversión), explica por qué ambos tipos de métricas deben coexistir en el gate.

El KPI primario podría ser la tasa de errores como 5xx < 1% durante una ventana de observación de 15 minutos. Donde si el canary se mantiene bajo ese umbral, se promueve; si no, rollback inmediato.

