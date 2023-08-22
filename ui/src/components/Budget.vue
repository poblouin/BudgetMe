<script setup>
import { computed, ref } from "vue";
import { useQuery } from "@vue/apollo-composable";
import { endOfMonth, formatISO } from "date-fns";
import { monthsListFormatted } from "@helpers/dates.js";
import { transactions, transactionCategories } from "@graphql/queries.js";

// Date range
const dateRange = monthsListFormatted();
const selectedDate = ref(dateRange[0].value);

// Transaction categories
const transactionCategoriesQuery = useQuery(transactionCategories)
const transactionCategoriesItems = computed(() => transactionCategoriesQuery.result?.value?.transactionCategories ?? [])

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

// Summary
const summary = computed(() => {
  return transactionCategoriesItems.value.map((category) => {
    const amount = transactionsItems.value
        .filter((t) => t.transactionCategory.id === category.id)
        .reduce((accumulator, currentValue) => accumulator + currentValue.amount, 0);

    return {
      category: category.name,
      amount: Math.abs(amount.toFixed(2))
    }
  }).sort((a,b) => b.amount - a.amount)
})
</script>

<template>
  <v-container>
    <v-row>
      <v-select
        v-model="selectedDate"
        :items="dateRange"
        placeholder="Date Range"
      />
    </v-row>
    <v-row>
      <v-list>
        <v-list-item
          v-for="item in summary"
          :key="item.id"
          :title="item.category"
        >
          <template #subtitle>
            {{ item.amount }} $
          </template>
        </v-list-item>
      </v-list>
    </v-row>
  </v-container>
</template>
