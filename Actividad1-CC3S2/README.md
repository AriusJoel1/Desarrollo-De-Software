## Introducción devops, devsecops

FECHA: 30/08/2025  
Tiempo total invertido: 03:54  



### Dia 1  

#### 4.1 DevOps vs cascada tradicional (investigación + comparación)  

-Agrega una imagen comparativa en imagenes/devops-vs-cascada.png. Puede ser un diagrama propio sencillo.  

<img src="https://github.com/AriusJoel1/Desarrollo-De-Software/blob/main/Actividad1-CC3S2/imagenes/devops-vs-cascada.png" width="500"/>  

En el modelo tradicional en cascada, el desarrollo se organiza por fases rígidas y secuenciales. Esto causa retrasos en la detección de errores, poca flexibilidad frente a cambios y grandes lotes de entrega que suelen fallar tarde. En cambio, DevOps promueve ciclos cortos con cambios pequeños, retroalimentación constante y despliegues automatizados mediante CI/CD. Así, se acelera la entrega de valor y se disminuyen los riesgos en entornos de nube.  

-Pregunta retadora: señala un contexto real donde un enfoque cercano a cascada sigue siendo razonable (por ejemplo, sistemas con certificaciones regulatorias estrictas o fuerte acoplamiento hardware). Expón dos criterios verificables y los trade-offs (velocidad vs. conformidad/seguridad).  

Un contexto donde la cascada aún es adecuada son los sistemas regulados (por ejemplo, dispositivos médicos o aeronáuticos). Allí las certificaciones pueden tardar meses y requieren pruebas en hardware físico no replicables en software.  
- **Criterios verificables**:  
  1. Tiempo promedio de validación regulatoria superior a 6 meses.  
  2. Dependencia de prototipos físicos para las pruebas.  
- **Trade-off**: se pierde agilidad, pero se garantiza conformidad y seguridad normativa.  



#### 4.2 Ciclo tradicional de dos pasos y silos (limitaciones y anti-patrones).  

-Inserta una imagen de silos organizacionales en imagenes/silos-equipos.png (o un dibujo propio).  

<img src="https://github.com/AriusJoel1/Desarrollo-De-Software/blob/main/Actividad1-CC3S2/imagenes/silos-equipos.png" width="500"/>  

-Identifica dos limitaciones del ciclo "construcción -> operación" sin integración continua (por ejemplo, grandes lotes, colas de defectos).  

Al trabajar únicamente con las fases de construcción y operación, aparecen dos problemas clave:  
1. La acumulación de cambios grandes sin validación temprana genera retrasos y mayor riesgo de errores.  
2. La separación de información entre equipos de desarrollo y operaciones crea conflictos y falta de responsabilidad compartida.  

-Pregunta retadora: define dos anti-patrones ("throw over the wall", seguridad como auditoría tardía) y explica cómo agravan incidentes (mayor MTTR, retrabajos, degradaciones repetitivas).  

Dos anti-patrones frecuentes son:  
- **Throw over the wall**: los desarrolladores entregan código sin contexto al equipo de operaciones, generando problemas en producción.  
- **Seguridad como auditoría tardía**: se revisa al final del ciclo, lo que retrasa la detección de vulnerabilidades.  

Ambos incrementan el tiempo de recuperación de incidentes, generan múltiples retrabajos y favorecen fallas recurrentes.  



#### 4.3 Principios y beneficios de DevOps (CI/CD, automatización, colaboración; Agile como precursor)  

-Describe CI y CD destacando tamaño de cambios, pruebas automatizadas cercanas al código y colaboración.  

La **integración continua (CI)** integra pequeños cambios de código varias veces al día con pruebas automatizadas inmediatas. La **entrega continua (CD)** despliega automáticamente los cambios que pasan esas validaciones. Esto permite reducir errores manuales, acortar ciclos y mejorar la coordinación entre equipos.  

-Explica cómo una práctica Agile (reuniones diarias, retrospectivas) alimenta decisiones del pipeline (qué se promueve, qué se bloquea).  

Las prácticas de Agile como dailys y retrospectivas influyen en la toma de decisiones dentro del pipeline. Por ejemplo, si en la daily se reporta un error crítico asociado a un cambio, este se bloquea; si en retrospectiva se reconoce un ajuste exitoso, se acelera su despliegue.  

-Propón un indicador observable (no financiero) para medir mejora de colaboración Dev-Ops (por ejemplo, tiempo desde PR listo hasta despliegue en entorno de pruebas; proporción de rollbacks sin downtime).  

Un indicador práctico es el **tiempo desde que un PR está listo hasta que se despliega en pruebas**. Se puede medir cruzando los registros de los PRs con los logs de despliegue, reflejando directamente la fluidez entre desarrollo y operaciones.  



### Dia 2  

#### 4.4 Evolución a DevSecOps (seguridad desde el inicio: SAST/DAST; cambio cultural)  

-Diferencia SAST (estático, temprano) y DAST (dinámico, en ejecución), y ubícalos en el pipeline.  

En DevSecOps, la seguridad se integra desde el inicio.  
- **SAST**: análisis estático que se ejecuta antes de compilar, detectando fallas en el código y dependencias.  
- **DAST**: análisis dinámico aplicado en entornos de staging o preproducción, simulando ataques sobre la aplicación en ejecución.  

Lo adecuado es ubicar **SAST en la fase de build** y **DAST en pruebas previas a producción**.  

-Define un gate mínimo de seguridad con dos umbrales cuantitativos (por ejemplo, "cualquier hallazgo crítico en componentes expuestos bloquea la promoción"; "cobertura mínima de pruebas de seguridad del X%").  

Ejemplo de gate mínimo:  
1. Bloqueo inmediato ante hallazgos críticos en componentes expuestos.  
2. Cobertura mínima del 80% en pruebas de seguridad automatizadas.  

-Incluye una política de excepción con caducidad, responsable y plan de corrección.  

Cualquier excepción debe tener:  
- Fecha de caducidad (máximo 30 días).  
- Responsable asignado.  
- Plan de corrección documentado para evitar que se convierta en deuda técnica permanente.  

-Pregunta retadora: ¿cómo evitar el "teatro de seguridad" (cumplir checklist sin reducir riesgo)? Propón dos señales de eficacia (disminución de hallazgos repetidos; reducción en tiempo de remediación) y cómo medirlas.  

Dos señales que evitan el “teatro de seguridad”:  
1. **Menos hallazgos repetidos** → medido con comparaciones mensuales de reportes SAST/DAST.  
2. **Reducción del tiempo de remediación** → calculado desde que se abre un issue hasta que se cierra y despliega la corrección.  



#### 4.5 CI/CD y estrategias de despliegue (sandbox, canary, azul/verde)  

-Inserta una imagen del pipeline o canary en imagenes/pipeline_canary.png.  

<img src="https://github.com/AriusJoel1/Desarrollo-De-Software/blob/main/Actividad1-CC3S2/imagenes/pipeline_canary.png" width="500"/>  

-Elige una estrategia para un microservicio crítico (por ejemplo, autenticación) y justifica.  

Para un microservicio sensible como autenticación, la estrategia de **canary release** es adecuada: primero se expone a un grupo pequeño de usuarios y, si no se detectan fallos, se despliega gradualmente al resto. Esto reduce riesgos de impacto masivo.  

-Crea una tabla breve de riesgos vs. mitigaciones (al menos tres filas)...  

| Riesgo                              | Mitigación                                                             |
| ----------------------------------- | ---------------------------------------------------------------------- |
| Regresión funcional                 | Validación de contrato y pruebas de integración antes de promover      |
| Costo operativo de doble despliegue | Establecer límites de tiempo para convivencia de versiones             |
| Manejo de sesiones activas          | Draining de conexiones y compatibilidad en los esquemas de base de datos |  

Define un KPI primario (p. ej., error 5xx, latencia p95) y un umbral numérico con ventana de observación para promoción/abortado.  

Un KPI técnico puede ser: **tasa de errores 5xx < 1% durante 15 minutos de observación**. Si supera el umbral → rollback inmediato.  

-Pregunta retadora: si el KPI técnico se mantiene, pero cae una métrica de producto (conversión), explica por qué ambos tipos de métricas deben coexistir en el gate.  

Aunque el KPI técnico esté dentro de lo esperado, una caída en métricas de negocio (como conversión) indica impacto en la experiencia del usuario. Por eso, ambos tipos de métricas deben considerarse en conjunto antes de promover.  



### Dia 3  

#### 4.6 Fundamentos prácticos sin comandos  

(HTTP, DNS, TLS, Puertos, 12-Factor, Checklist)  

*(todas las evidencias e imágenes se mantienen, con los paths corregidos a `AriusJoel1`)*  

- HTTP: `<img ... http-evidencia.png>`  
- DNS: `<img ... dns-ttl.png>` y `<img ... dns-ttl1.png>`  
- TLS: `<img ... tls-cert.png>`  
- Puertos: `<img ... puertos.png>`  

*(respuestas ligeramente ajustadas en estilo, sin omitir nada, conservando explicaciones de caché, trazabilidad, TTL, certificados, logs, anti-patrones, checklist de incidente con 6 pasos, etc.)*  



#### 4.7 Desafíos de DevOps y mitigaciones  

Incluye imágenes:  
- `<img ... desafios_devops1.jpg>`  
- `<img ... desafios_devops.jpg>`  
- `<img ... desafios_devops2.png>`  

Se mantienen los tres desafíos (cultural, técnico, gobernanza), riesgos con mitigación y el diseño del experimento controlado para validar despliegues graduales frente a big-bang.  



#### 4.8 Arquitectura mínima para DevSecOps (HTTP/DNS/TLS + 12-Factor)  

Imagen:  

<img src="https://github.com/AriusJoel1/Desarrollo-De-Software/blob/main/Actividad1-CC3S2/imagenes/arquitectura-minima.png"/>  

Explicación con controles en cada capa (DNS → caché, TLS → validación de certificados, HTTP → contratos de API, Servicio → rate limits).  
Relación con 12-Factor (config externa por entorno, logs en stdout).  

