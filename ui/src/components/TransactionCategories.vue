<script setup>
import { VDataTable } from "vuetify/labs/components";
import {computed, nextTick, ref, watch} from "vue";
import { useMutation, useQuery } from "@vue/apollo-composable";
import {
  transactionCategories,
  transactionCategoryCreate,
  transactionCategoryUpdate,
  transactionCategoryDelete
} from "@graphql/queries.js";

// Data table
const headers = [
  { title: 'Name', key: 'name' },
  { title: 'Actions', key: 'actions', sortable: false },
]
const transactionCategoriesQuery = useQuery(transactionCategories)
const transactionCategoriesItems = computed(() => transactionCategoriesQuery.result?.value?.transactionCategories ?? [])

// Dialog
const dialog = ref(false)
const dialogDelete = ref(false)
const editedItem = ref({ id: null, name: '' })
const defaultItem = ref({ id: null, name: '' })
const dialogTitle = computed(() => `${editedItem.value.id ? 'Edit' : 'New'} Category`)
const editErrorMsg = ref([])

const transactionCategoryCreateMutation = useMutation(transactionCategoryCreate)
const transactionCategoryUpdateMutation = useMutation(transactionCategoryUpdate)
const transactionCategoryDeleteMutation = useMutation(transactionCategoryDelete)

watch(dialog, () => clearError())

const saveItem = () => editedItem.value.id ? updateCategory() : createCategory()

const editItem = (item) => {
  editedItem.value = { ...item }
  dialog.value = true
}

const deleteItem = (item) => {
  editedItem.value = transactionCategoriesItems.value.find((t) => t.id === item.id)
  dialogDelete.value = true
}

const resetEditedItem = () => {
  nextTick(() => editedItem.value = { ...defaultItem.value })
}

const clearError = () => editErrorMsg.value = []

const close = () => {
  dialog.value = false
  resetEditedItem()
}

const closeDelete = () => {
  dialogDelete.value = false
  resetEditedItem()
}

const createCategory = async () => {
  try {
    const variables = { input: {params: { name: editedItem.value.name }}}
    await transactionCategoryCreateMutation.mutate(variables)
    await transactionCategoriesQuery.refetch()
    close()
  } catch (e) {
    editErrorMsg.value = e.message
  }
}

const updateCategory = async () => {
  try {
    const variables = { input: { id: editedItem.value.id, params: { name: editedItem.value.name }}}
    await transactionCategoryUpdateMutation.mutate(variables)
    await transactionCategoriesQuery.refetch()
    close()
  } catch (e) {
    editErrorMsg.value = e.message
  }
}

const deleteCategory = async () => {
  try {
    await transactionCategoryDeleteMutation.mutate( { input: {id: editedItem.value.id }})
    await transactionCategoriesQuery.refetch()
    closeDelete()
  } catch (e) {
    console.log(e.message)
  }
}
</script>

<template>
  <v-data-table
    :headers="headers"
    :hover="true"
    :items="transactionCategoriesItems"
    :sort-by="[{ key: 'name', order: 'asc' }]"
    class="elevation-1"
  >
    <template #top>
      <v-toolbar
        flat
      >
        <v-spacer />
        <v-dialog
          v-model="dialog"
          max-width="500px"
        >
          <template #activator="{ props }">
            <v-btn
              color="primary"
              v-bind="props"
            >
              New Category
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="text-h5">{{ dialogTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-text-field
                v-model="editedItem.name"
                label="Category name"
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
                @click="saveItem"
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
              Are you sure you want to delete this category?
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
                @click="deleteCategory"
              >
                OK
              </v-btn>
              <v-spacer />
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
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
  </v-data-table>
</template>