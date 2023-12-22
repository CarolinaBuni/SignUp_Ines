# Usar una imagen base con Node.js
FROM node:latest AS build

# Establecer el directorio de trabajo en la imagen
WORKDIR /app

# Copiar los archivos del proyecto al directorio de trabajo
COPY . .

# Instalar las dependencias
RUN npm install

# Construir la aplicación
RUN npm run build

# Usar una imagen ligera de Nginx para servir la aplicación construida
FROM nginx:alpine

# Copiar los archivos de construcción de la aplicación al directorio de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto 80 para servir la aplicación
EXPOSE 8080

# Comando para arrancar el servidor de Nginx
CMD ["nginx", "-g", "daemon off;"]
