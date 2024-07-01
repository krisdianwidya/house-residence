import { createRouter, createWebHistory } from "vue-router";

import Home from "./Pages/Home.vue";
import People from "./Pages/People.vue";
import HouseDetail from "./Pages/HouseDetail.vue";

const routes = [ {
    path: "/",
    redirect: "/house",

},
{
    path: "/house",
    component: Home,
},
{
    path: '/house/detail/:id',
    component: HouseDetail,
},
{
    path: "/people",
    component: People,
},
];

export default createRouter({
    history: createWebHistory(),
    routes,
});