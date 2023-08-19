<script setup>
import {computed, ref} from "vue";
import { useQuery } from '@vue/apollo-composable'
import { VDataTable } from 'vuetify/labs/VDataTable'
import { formatISO } from "date-fns";
import { transactions } from "@graphql/queries.js";

const transactionsQuery = useQuery(transactions, { from: formatISO(new Date(2023, 7, 1)) })
const transactionsItems = computed(() => transactionsQuery.result?.value?.transactions ?? [])
const itemsPerPage = -1 // all
const search = ref('')
const sortBy = [{key: 'date', order: 'desc'}]

const headers = [
  { title: 'Date', key: 'date' },
  { title: 'Merchant', key: 'merchantName' },
  { title: 'Amount', key: 'amount' },
  { title: 'Category', key: 'transactionCategory.name' },
]
</script>

<template>
  <v-card width="100vw">
    <v-card-title>
      Transactions
      <v-spacer />
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
      />
    </v-card-title>
    <v-data-table
      v-model:items-per-page="itemsPerPage"
      :headers="headers"
      :items="transactionsItems"
      :search="search"
      :sort-by="sortBy"
      hover="true"
    />
  </v-card>
</template>
