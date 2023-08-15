import { createRouter, createWebHistory } from 'vue-router'
import Home from "@components/Home.vue";
import TransactionCategories from "@components/TransactionCategories.vue";

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/transaction-categories',
        name: 'Transaction Categories',
        component: TransactionCategories
    },
]
const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router
