import { createRouter, createWebHistory } from 'vue-router'
import TransactionCategories from "@components/TransactionCategories.vue";
import Transactions from "../components/Transactions.vue";

const routes = [
    {
        path: '/',
        redirect: '/transactions'
    },
    {
        path: '/transactions',
        name: 'Transactions',
        component: Transactions
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
