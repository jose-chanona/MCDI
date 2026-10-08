# Práctica 2B — PCA para preprocesar datos

Análisis de la reducción de dimensionalidad mediante **Análisis de Componentes Principales (PCA)** y su efecto en la calidad de los clusters generados con **K-means** sobre el conjunto de datos MNIST.

## Información académica

- **Programa:** Maestría en Ciencia de Datos e Información (MCDI)
- **Materia:** Manejo y Procesamiento de la Información
- **Estudiante:** Chanona Leyva José Luis
- **Profesor:** Dr. Luis Guillermo Ruiz Velázquez
- **Lenguaje:** Python 3
- **Entorno recomendado:** Google Colab o Jupyter Notebook

## Objetivo

Comparar la calidad de K-means antes y después de aplicar PCA utilizando la métrica `rand_score`.

El notebook desarrolla dos experimentos:

1. Clases 0 y 1 de MNIST, con reducción a dos componentes para visualizar los datos.
2. De 2 a 10 clases, comparando K-means con las 784 variables originales frente a PCA con 50 componentes.

## Metodología

1. Descargar MNIST mediante `fetch_openml`.
2. Estandarizar las variables con `StandardScaler`.
3. Aplicar PCA con 2 y 50 componentes, según el experimento.
4. Entrenar K-means con `random_state=1`.
5. Comparar las etiquetas generadas con las clases reales mediante `rand_score`.
6. Interpretar los resultados mediante tablas y gráficas.

## Resultados principales

### Clases 0 y 1

| Representación | Rand score |
|---|---:|
| 784 variables escaladas | 0.9792 |
| 2 componentes PCA | 0.9737 |

La reducción a dos dimensiones facilita la visualización, aunque produce una disminución pequeña en la métrica.

### Comparación de 2 a 10 clases

En este experimento se utiliza una muestra balanceada de 300 imágenes por clase para mantener un tiempo de ejecución razonable y evitar un consumo excesivo de memoria.

La mayor mejora al aplicar PCA con 50 componentes se obtuvo con **10 clases**:

- Sin PCA: `rand_score = 0.8555`
- Con PCA: `rand_score = 0.8603`
- Mejora: `+0.0048`

Es importante distinguir entre el mejor valor absoluto y la mayor mejora. El mejor `rand_score` absoluto con PCA se obtuvo con 2 clases, mientras que la mayor mejora respecto al modelo sin PCA ocurrió con 10 clases.

## Estructura del repositorio

```text
Practica_2B_PCA_GitHub/
├── Practica_2B_PCA.ipynb
├── README.md
├── requirements.txt
└── .gitignore
```

## Ejecución en Google Colab

1. Descarga o clona este repositorio.
2. Abre `Practica_2B_PCA.ipynb` en Google Colab.
3. Ejecuta las celdas en orden.
4. Autoriza la descarga de MNIST desde OpenML cuando sea necesario.

El conjunto MNIST no se incluye en el repositorio porque el notebook lo descarga mediante `fetch_openml`.

## Ejecución local

Instala las dependencias:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

En Windows, la activación puede realizarse con:

```powershell
.venv\Scripts\activate
```

Después, abre el notebook:

```bash
jupyter notebook Practica_2B_PCA.ipynb
```

## Reproducibilidad

El análisis utiliza:

- `random_state=1` en K-means;
- `random_state=1` en PCA;
- una muestra balanceada reproducible;
- código organizado de arriba hacia abajo;
- comentarios y explicaciones en cada etapa.

## Licencia

Este repositorio se entrega con fines académicos. Si se publica como repositorio público, se recomienda agregar una licencia de acuerdo con las condiciones de la institución y del autor.
