import './bootstrap';

import 'primeflex/primeflex.css'
import 'primevue/resources/themes/aura-light-green/theme.css'
import 'primeicons/primeicons.css'

import router from './router';
import { createApp } from "vue";
import PrimeVue from 'primevue/config';
import ToastService from 'primevue/toastservice';
import ConfirmationService from 'primevue/confirmationservice';

import App from "./App.vue";

createApp(App).use(router).use(PrimeVue).use(ToastService).use(ConfirmationService).mount("#app");