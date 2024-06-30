import { createRouter, createWebHistory } from "vue-router";

const routes = [ {
    path: "/",
    component: () => import("./Pages/Home.vue"),
},
{
    path: "/people",
    component: () => import("./Pages/People.vue"),
},];

export default createRouter({
    history: createWebHistory(),
    routes,
});