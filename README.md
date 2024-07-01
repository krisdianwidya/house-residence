## Intro

Project ini saya buat menggunakan laravel dan vue js, namun perlu diperhatikan bahwa project ini adalah project aplikasi fullstack secara monolitik dalam 1 repo, jadi tidak dibuat repo terpisah antata backend dan frontend.

Jadi saya menggunakan mekanisme untuk meload 1 view blade.php, yang mana view tersebut akan meload project vue yang ada dalam folder resources/js

## Cara run project

1. Tentu silakan clone repo ini
2. Manfaatkan sql dump yang ada di repo ini untuk diimport di xampp
3. Buka project dengan code editor
4. Buka terminal
5. run composer install
6. run npm install
7. buat file .env dengan copy paste isi file .env.example
8. run php artisan storage:link
9. run npm run dev
10. buka terminal baru lagi (sehingga terdapat 2 window terminal)
11. run php artisan serve (sehingga 1 terminal menjalankan npm run dev, dan 1 lagi menjalankan php artisan serve)
12. silakan buka url pada localhost
