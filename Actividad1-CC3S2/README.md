## Introducción devops, devsecops

FECHA: 31/08/2025  
Tiempo total invertido: 04:13  

### Dia 1

#### 4.1 DevOps vs cascada tradicional (investigación + comparación)

- Agrega una imagen comparativa en imagenes/devops-vs-cascada.png. Puede ser un diagrama propio sencillo.

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo_Software_CC3S2/main/Actividad1-CC3S2/imagenes/devops-vs-cascada.png" width="500"/>

Explica por qué DevOps acelera y reduce riesgo en software para la nube frente a cascada (feedback continuo, pequeños lotes, automatización).

En el modelo tradicional en cascada, el desarrollo se organiza en fases rígidas sin retroalimentación temprana. Esto provoca ciclos extensos, poca flexibilidad frente a cambios y despliegues en grandes lotes que retrasan la detección de errores. En contraste, DevOps promueve cambios pequeños y frecuentes mediante integración y entrega continua (CI/CD), automatización y feedback constante. Así, los fallos se detectan antes y el riesgo en despliegues de nube se reduce notablemente.

- Pregunta retadora: señala un contexto real donde un enfoque cercano a cascada sigue siendo razonable (por ejemplo, sistemas con certificaciones regulatorias estrictas o fuerte acoplamiento hardware). Expón dos criterios verificables y los trade-offs (velocidad vs. conformidad/seguridad).

Un contexto cercano a cascada es el desarrollo de sistemas regulados o hardware cerrado, como los dispositivos médicos o sistemas de control industrial. Allí, los ciclos de certificación pueden tardar 6 meses y dependen de pruebas físicas no reproducibles digitalmente.  
**Trade-off**: se sacrifica velocidad para priorizar conformidad regulatoria y seguridad.


#### 4.2 Ciclo tradicional de dos pasos y silos (limitaciones y anti-patrones)

- Inserta una imagen de silos organizacionales en imagenes/silos-equipos.png (o un dibujo propio).

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo_Software_CC3S2/main/Actividad1-CC3S2/imagenes/silos-equipos.png" width="500"/>

- Identifica dos limitaciones del ciclo "construcción -> operación" sin integración continua.

1. Cambios en grandes lotes que acumulan defectos y generan cuellos de botella.  
2. Poca coherencia de información entre equipos, lo que fomenta disputas y culpas cruzadas.

- Pregunta retadora: define dos anti-patrones ("throw over the wall", seguridad como auditoría tardía) y explica cómo agravan incidentes.

1. **Throw over the wall**: los devs lanzan código sin contexto al equipo de operaciones → mayor MTTR y retrabajo.  
2. **Seguridad como auditoría tardía**: problemas detectados al final del ciclo → degradaciones repetitivas y correcciones costosas.


#### 4.3 Principios y beneficios de DevOps (CI/CD, automatización, colaboración; Agile como precursor)

- Describe CI y CD destacando tamaño de cambios, pruebas automatizadas cercanas al código y colaboración.

DevOps se apoya en **CI**, donde se integran cambios pequeños varias veces al día, y en **CD**, donde esos cambios pasan automáticamente a entornos tras superar pruebas. Esto mejora la calidad, reduce errores manuales y permite respuestas rápidas ante fallos.

- Explica cómo una práctica Agile (reuniones diarias, retrospectivas) alimenta decisiones del pipeline.

Las reuniones diarias y retrospectivas permiten decidir qué PRs o versiones promover y cuáles bloquear. Ejemplo: si un cambio causa conflicto, se detiene; si fue bien recibido, se acelera su paso por el pipeline.

- Propón un indicador observable (no financiero) para medir mejora de colaboración Dev-Ops.

**Indicador**: tiempo promedio entre *PR listo* y *despliegue en entorno de pruebas*, medido con timestamps de PRs y registros de despliegue.


### Dia 2

#### 4.4 Evolución a DevSecOps (seguridad desde el inicio: SAST/DAST; cambio cultural)

- Diferencia SAST (estático, temprano) y DAST (dinámico, en ejecución), y ubícalos en el pipeline.

- **SAST**: revisa el código antes de compilar, detectando vulnerabilidades en dependencias o malas prácticas (fase de build).  
- **DAST**: se ejecuta en entornos de pruebas, simulando ataques reales sobre la aplicación en ejecución (fase de staging/preproducción).

- Define un gate mínimo de seguridad con dos umbrales cuantitativos.

1. Bloquear cualquier hallazgo crítico en servicios expuestos.  
2. Requerir al menos **80% de cobertura** en pruebas de seguridad automatizadas antes de promover.

- Incluye una política de excepción con caducidad, responsable y plan de corrección.

Toda excepción debe tener:  
- Fecha límite (ej. 30 días).  
- Responsable asignado.  
- Plan de corrección documentado.

- Pregunta retadora: ¿cómo evitar el "teatro de seguridad" (cumplir checklist sin reducir riesgo)?

Dos señales de eficacia:  
1. **Menos hallazgos repetidos** (comparando reportes SAST/DAST mes a mes).  
2. **Reducción en tiempo de remediación** (desde issue abierto hasta deploy con fix).


#### 4.5 CI/CD y estrategias de despliegue (sandbox, canary, azul/verde)

- Inserta una imagen del pipeline o canary en imagenes/pipeline_canary.png.

<img src="https://raw.githubusercontent.com/AriusJoel1/Desarrollo_Software_CC3S2/main/Actividad1-CC3S2/imagenes/pipeline_canary.png" width="500"/>

- Elige una estrategia para un microservicio crítico y justifica.

Para un microservicio crítico como autenticación, una **estrategia canary release** es ideal: se expone la nueva versión a un porcentaje reducido de usuarios y, si las métricas se mantienen dentro de los umbrales, se expande al resto.

- Crea una tabla breve de riesgos vs. mitigaciones.

| Riesgo                              | Mitigación                                                           |
| ----------------------------------- | -------------------------------------------------------------------- |
| Regresión funcional                 | Validación de contrato y pruebas de integración antes de promover    |
| Costo operativo de doble despliegue | Límites de tiempo para convivencia de versiones                      |
| Manejo de sesiones activas          | Draining de conexiones y compatibilidad en esquemas de base de datos |

- Define un KPI primario y un umbral.

**KPI primario**: tasa de errores `5xx < 1%` en una ventana de 15 minutos.  
Si se cumple → promoción.  
Si no → rollback inmediato.

- Pregunta retadora: si el KPI técnico se mantiene, pero cae una métrica de producto (conversión), explica por qué ambos tipos de métricas deben coexistir.

Porque las métricas técnicas aseguran estabilidad, pero las de producto garantizan que el cambio no daña la experiencia del usuario ni los objetivos del negocio. Ambas deben coexistir en los gates.
