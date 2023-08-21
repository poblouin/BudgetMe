<script setup>
import { eachMonthOfInterval, endOfMonth, format, formatISO, getYear } from "date-fns";
import { computed, nextTick, ref, watch } from "vue";
import { useMutation, useQuery } from '@vue/apollo-composable'
import { VDataTable } from "vuetify/labs/components";
import { transactions, transactionDelete, transactionUpdate, transactionCategories } from "@graphql/queries.js";

// Dialog
const dialog = ref(false)
const dialogDelete = ref(false)
const editedItem = ref()
const editErrorMsg = ref([])
const selectedCategory = ref()

const transactionCategoriesQuery = useQuery(transactionCategories)
const transactionCategoriesSelectItems = computed(() => {
  const items = transactionCategoriesQuery.result?.value?.transactionCategories ?? []
  return items.map((item) => ({ title: item.name, value: item }))
})
const transactionUpdateMutation = useMutation(transactionUpdate)
const transactionDeleteMutation = useMutation(transactionDelete)

watch([dialog, dialogDelete], (newValue) => {
  newValue.every((v) => !v) && resetDialogVars()
})

const editItem = (item) => {
  editedItem.value = item
  selectedCategory.value = transactionCategoriesSelectItems.value.find((i) => i.value.id === item.transactionCategory.id)
  dialog.value = true
}

const deleteItem = (item) => {
  editedItem.value = item
  dialogDelete.value = true
}

const resetDialogVars = () => {
  nextTick(() => {
    editedItem.value = null
    selectedCategory.value = null
    editErrorMsg.value = []
  })
}

const close = () => {
  dialog.value = false
}

const closeDelete = () => {
  dialogDelete.value = false
}

const updateCategory = async () => {
  const newCategoryId = selectedCategory.value.id

  if (newCategoryId === editedItem.value.transactionCategory.id) {
    close()
    return;
  }

  try {
    const variables = {
      input: {
        id: editedItem.value.id,
        params: { transactionCategoryId: newCategoryId }
      }
    }
    await transactionUpdateMutation.mutate(variables)
    await transactionsQuery.refetch()

    close()
  } catch (e) {
    editErrorMsg.value = e.message
  }
}

const deleteTransaction = async () => {
  try {
    await transactionDeleteMutation.mutate( { input: {id: editedItem.value.id }})
    await transactionsQuery.refetch()
    closeDelete()
  } catch (e) {
    console.log(e.message)
  }
}

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
  { title: 'Actions', key: 'actions', sortable: false },
]
</script>

<template>
  <v-dialog
    v-model="dialog"
    max-width="500px"
  >
    <v-card>
      <v-card-title>
        <span class="text-h5">Edit Category</span>
      </v-card-title>
      <v-card-text>
        <v-select
          v-model="selectedCategory"
          :items="transactionCategoriesSelectItems"
          :error-messages="editErrorMsg"
        />
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn
          variant="text"
          @click="close"
        >
          Cancel
        </v-btn>
        <v-btn
          color="primary"
          variant="text"
          @click="updateCategory"
        >
          Save
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
  <v-dialog
    v-model="dialogDelete"
    max-width="500px"
  >
    <v-card>
      <v-card-title class="text-h5">
        Are you sure you want to delete this transaction?
      </v-card-title>
      <v-card-actions>
        <v-spacer />
        <v-btn
          variant="text"
          @click="closeDelete"
        >
          Cancel
        </v-btn>
        <v-btn
          color="primary"
          variant="text"
          @click="deleteTransaction"
        >
          OK
        </v-btn>
        <v-spacer />
      </v-card-actions>
    </v-card>
  </v-dialog>
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
        <template #[`item.actions`]="{ item }">
          <v-icon
            size="small"
            class="me-2"
            @click="editItem(item.raw)"
          >
            mdi-pencil
          </v-icon>
          <v-icon
            size="small"
            @click="deleteItem(item.raw)"
          >
            mdi-delete
          </v-icon>
        </template>
        <template #bottom />
      </v-data-table>
    </v-row>
  </v-row>
</template>
