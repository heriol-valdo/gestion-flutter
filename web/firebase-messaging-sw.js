
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
      apiKey: "AIzaSyBwEHVYmHwz7jXCUg_54RVuNZFHyaVIK0w",
      authDomain: "chat-9fc74.firebaseapp.com",
      projectId: "chat-9fc74",
      storageBucket: "chat-9fc74.appspot.com",
      messagingSenderId: "190919531619",
      appId: "1:190919531619:web:aa73cc35b3be64b0232c56",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});