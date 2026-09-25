# Tarea 2 - Resolución de problemas. Aplicaciones de probabilidad
# Alumno: Chanona Leyva José Luis
# ES/EN: Código reproducible en R / Reproducible R code

# -------------------------
# Ejercicio 3: Chiapas
# -------------------------
# ES/EN: Crear la secuencia de años del periodo solicitado / Create the requested years.
anios <- 1993:2023
# ES/EN: Capturar los valores de temperatura proporcionados / Enter the supplied temperatures.
temperatura <- c(23.9, 24, 23.9, 23.8, 24, 23.8, 23.5, 23.6,
                 23.8, 24, 24, 24, 24.7, 25.4, 25, 24.5,
                 24.4, 24.3, 24.3, 24.6, 24.9, 24.5, 25.2,
                 26.1, 25.6, 25.3, 25.7, 25.5, 25.2, 24.5, 25.4)
# ES/EN: Centrar el año en 2008 para simplificar las sumas / Center year at 2008.
t <- anios - 2008
# ES/EN: Organizar años, variable centrada y temperatura / Organize the variables.
datos_chiapas <- data.frame(anio = anios, t = t, temperatura = temperatura)

# ES/EN: Ajuste por mínimos cuadrados / Least-squares fits
# ES/EN: Ajustar la recta / Fit the linear model.
modelo_lineal <- lm(temperatura ~ t, data = datos_chiapas)
# ES/EN: Ajustar el modelo cuadrático / Fit the quadratic model.
modelo_cuadratico <- lm(temperatura ~ t + I(t^2), data = datos_chiapas)
# ES/EN: Ajustar el modelo cúbico / Fit the cubic model.
modelo_cubico <- lm(temperatura ~ t + I(t^2) + I(t^3), data = datos_chiapas)
# ES/EN: Mostrar el resumen de cada ajuste / Display each model summary.
summary(modelo_lineal)
summary(modelo_cuadratico)
summary(modelo_cubico)

# ES/EN: Abrir un archivo PNG para la figura de temperaturas / Open PNG output.
png("figura_1_temperaturas_chiapas.png", width = 1600, height = 950, res = 180)
# ES/EN: Graficar las observaciones / Plot the observations.
plot(anios, temperatura, pch = 19, col = "#72163A",
     xlab = "Año / Year", ylab = "Temperatura media (°C) / Mean temperature (°C)",
     main = "Temperatura media anual de Chiapas / Annual mean temperature of Chiapas")
# ES/EN: Añadir los valores ajustados de cada modelo / Add fitted values.
lines(anios, fitted(modelo_lineal), col = "#B58A4A", lwd = 2)
lines(anios, fitted(modelo_cuadratico), col = "#2D6A8A", lwd = 2)
lines(anios, fitted(modelo_cubico), col = "#333333", lwd = 2)
# ES/EN: Añadir la leyenda / Add the legend.
legend("topleft", legend = c("Observada / Observed", "Lineal / Linear",
                             "Cuadrática / Quadratic", "Cúbica / Cubic"),
       col = c("#72163A", "#B58A4A", "#2D6A8A", "#333333"),
       pch = c(19, NA, NA, NA), lty = c(NA, 1, 1, 1), bty = "n")
# ES/EN: Cerrar el archivo gráfico / Close the graphics device.
dev.off()

# -------------------------
# Ejercicio 5: PCA
# -------------------------
# ES/EN: Cargar la base USArrests incluida en R / Load R's built-in data set.
datos <- USArrests
# ES/EN: Centrar sin estandarizar para exportar una tabla / Center only for export.
centrados <- scale(datos, center = TRUE, scale = FALSE)
# ES/EN: Guardar las variables centradas / Save centered variables.
write.csv(as.data.frame(centrados), "tabla_variables_centradas.csv")

# ES/EN: Se estandariza porque las variables tienen escalas distintas.
# Standardization is used because the variables have different scales.
# ES/EN: Centrar y dividir entre la desviación estándar / Center and scale variables.
estandarizados <- scale(datos, center = TRUE, scale = TRUE)
# ES/EN: Calcular la matriz de covarianzas / Calculate the covariance matrix.
matriz_covarianza <- cov(estandarizados)
# ES/EN: Obtener valores y vectores propios / Obtain eigenvalues and eigenvectors.
descomposicion <- eigen(matriz_covarianza)
# ES/EN: Ejecutar PCA y conservar las cuatro componentes / Run PCA and keep four PCs.
pca <- prcomp(datos, center = TRUE, scale. = TRUE)
# ES/EN: Convertir los puntajes de componentes a tabla / Convert scores to a table.
componentes <- as.data.frame(pca$x)
# ES/EN: Exportar los puntajes / Export the component scores.
write.csv(componentes, "tabla_componentes_principales.csv")

# ES/EN: Abrir el archivo PNG para el gráfico de PC1 y PC2 / Open PNG output.
png("figura_2_pca_usarrests.png", width = 1600, height = 1100, res = 180)
# ES/EN: Dibujar un plano vacío con las escalas de las dos primeras PC.
plot(pca$x[,1], pca$x[,2], type = "n",
     xlab = "PC1", ylab = "PC2",
     main = "PCA de USArrests / PCA of USArrests")
# ES/EN: Colocar el nombre de cada estado / Add each state name.
text(pca$x[,1], pca$x[,2], rownames(datos), cex = 0.65)
# ES/EN: Añadir líneas de referencia en cero / Add zero reference lines.
abline(h = 0, v = 0, col = "grey75")
# ES/EN: Cerrar el archivo gráfico / Close the graphics device.
dev.off()

# ES/EN: Abrir el PNG para la varianza explicada / Open PNG output.
png("figura_3_varianza_pca.png", width = 1400, height = 850, res = 180)
# ES/EN: Calcular valores propios y porcentajes de varianza / Calculate variance shares.
varianza <- pca$sdev^2
porcentaje <- 100 * varianza / sum(varianza)
# ES/EN: Graficar la varianza explicada por componente / Plot explained variance.
barplot(porcentaje, names.arg = paste0("PC", 1:4),
        ylab = "Varianza explicada (%)",
        main = "Varianza explicada por componente / Explained variance")
# ES/EN: Cerrar el archivo gráfico / Close the graphics device.
dev.off()
