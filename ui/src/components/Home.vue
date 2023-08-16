<script setup>
import { useQuery } from '@vue/apollo-composable'
import { formatISO } from "date-fns";
import { transactions } from "@graphql/queries.js";

const { result } = useQuery(transactions, { from: formatISO(new Date(2023, 7, 1)) })
</script>

<template>
  {{ result }}
</template>
