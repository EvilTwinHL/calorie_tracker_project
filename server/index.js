const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');
require('dotenv').config();

const app = express();

// Базові налаштування
app.use(cors());
app.use(express.json());

// Ініціалізація Firebase Admin
// Ключ будемо передавати через змінні оточення (Environment Variables) на Render
if (process.env.FIREBASE_SERVICE_ACCOUNT) {
    try {
        const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount)
        });
        console.log('Firebase Admin успішно ініціалізовано');
    } catch (error) {
        console.error('Помилка парсингу FIREBASE_SERVICE_ACCOUNT:', error);
    }
} else {
    console.warn('УВАГА: Firebase Admin не ініціалізовано. Відсутня змінна FIREBASE_SERVICE_ACCOUNT.');
}

// Ping-Pong ендпоінт для cron-job (щоб Render не засинав)
app.get('/ping', (req, res) => {
    res.status(200).send('pong');
});

// Головний роут для перевірки працездатності
app.get('/', (req, res) => {
    res.send('Calorie Tracker API is running!');
});

// Запуск сервера
const PORT = process.env.PORT || 8000; // Змінили дефолтний порт на 8000
app.listen(PORT, '0.0.0.0', () => {    // Додали '0.0.0.0'
    console.log(`Сервер працює на порту ${PORT}`);
});