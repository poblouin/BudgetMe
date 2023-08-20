<script setup>
import { eachMonthOfInterval, endOfMonth, format, formatISO, getYear } from "date-fns";
import { computed, ref } from "vue";
import { useQuery } from '@vue/apollo-composable'
import { VDataTable } from "vuetify/labs/components";
import { transactions } from "@graphql/queries.js";

// Date range
const monthsList = () => {
  const currentDate = new Date();

  return eachMonthOfInterval({
    start: new Date(getYear(currentDate) - 1, 0, 1),
    end: currentDate,
  }).reverse().map((date) => {
    return {
      title: format(date, 'yyyy MMMM'),
      value: date,
    }
  })
};
const dateRange = monthsList();
const selectedDate = ref(dateRange[0].value);

// Transactions
const transactionQueryVariables = computed(() => {
  if (!selectedDate?.value) return;

  const date = selectedDate.value
  return {
    from: formatISO(date, { representation: 'date' }),
    to: formatISO(endOfMonth(date), { representation: 'date' })
  }
})
const transactionsQuery = useQuery(transactions, transactionQueryVariables)
const transactionsItems = computed(() => transactionsQuery.result?.value?.transactions ?? [])

// Data table
const itemsPerPage = -1 // all
const search = ref('')
const sortBy = [{ key: 'date', order: 'desc' }]

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
      Date Range
      <v-spacer />
      <v-select
        v-model="selectedDate"
        :items="dateRange"
      />
    </v-card-title>
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
      :hover="true"
    />
  </v-card>
</template>
