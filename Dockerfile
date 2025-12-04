# Menggunakan base image Node.js versi 14 (sesuai ketentuan)
FROM node:14

# Menentukan direktori kerja di dalam container sebagai /app
WORKDIR /app

# Menyalin seluruh source code dari direktori saat ini ke dalam container
COPY . .

# Menentukan environment agar berjalan di production
# dan menggunakan item-db sebagai host database (sesuai instruksi)
ENV NODE_ENV=production
ENV DB_HOST=item-db

# Menginstal dependencies untuk production dan melakukan build aplikasi
# --unsafe-perm: menghindari masalah permission saat menjalankan skrip npm di dalam container
RUN npm install --production --unsafe-perm && npm run build

# Mengekspos port 8080 yang digunakan aplikasi di dalam container
EXPOSE 8080

# Perintah yang dijalankan ketika container diluncurkan: menjalankan server Node.js
CMD ["npm", "start"]
