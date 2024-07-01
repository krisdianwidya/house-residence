import { createRouter, createWebHistory } from "vue-router";

import Home from "./Pages/Home.vue";
import Person from "./Pages/Person.vue";
import HouseDetail from "./Pages/HouseDetail.vue";
import PersonDetail from "./Pages/PersonDetail.vue";

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
    path: "/person",
    component: Person,
},
{
    path: '/person/detail/:id',
    component: PersonDetail,
},
];

export default createRouter({
    history: createWebHistory(),
    routes,
});