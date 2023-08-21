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
  <v-row no-gutters>
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-title>
          Filters
        </v-expansion-panel-title>
        <v-expansion-panel-text>
          <v-row no-gutters>
            <v-col class="mr-4">
              <v-text-field
                v-model="search"
                :clearable="true"
                hide-details
                label="Search"
                single-line
              />
            </v-col>
            <v-col>
              <v-select
                v-model="selectedDate"
                :items="dateRange"
                placeholder="Date Range"
              />
            </v-col>
          </v-row>
        </v-expansion-panel-text>
      </v-expansion-panel>
    </v-expansion-panels>
    <v-row no-gutters>
      <v-data-table
        v-model:items-per-page="itemsPerPage"
        :headers="headers"
        hide-default-footer
        :items="transactionsItems"
        :search="search"
        :sort-by="sortBy"
        :hover="true"
      >
        <template #bottom />
      </v-data-table>
    </v-row>
  </v-row>
</template>
