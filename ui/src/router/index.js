import { createRouter, createWebHistory } from 'vue-router'
import TransactionCategories from "@components/TransactionCategories.vue";
import Transactions from "@components/Transactions.vue";
import Budget from "@components/Budget.vue";

const routes = [
    {
        path: '/',
        redirect: '/budget'
    },
    {
        path: '/budget',
        name: 'Budget',
        component: Budget
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
