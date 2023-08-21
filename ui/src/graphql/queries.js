import { gql } from "graphql-tag"


// transactions
export const transactions = gql`
    query transactions($from: ISO8601Date, $to: ISO8601Date) {
        transactions(from: $from, to: $to) {
            id,
            amount,
            date,
            merchantName,
            transactionCategory {
                id,
                name,
            }
        }
    }
`

// transaction categories
export const transactionCategories = gql`
    query transactionCategories {
        transactionCategories {
          id,
          name,
        }
    }
`

export const transactionCategoryCreate = gql`
    mutation transactionCategoryCreate($input: TransactionCategoryCreateInput!) {
        transactionCategoryCreate(input: $input) {
            transactionCategory {
                id,
                name,
            }
        }
    }
`

export const transactionCategoryUpdate = gql`
    mutation transactionCategoryUpdate($input: TransactionCategoryUpdateInput!) {
        transactionCategoryUpdate(input: $input) {
            transactionCategory {
                id,
                name,
            }
        }
    }
`

export const transactionCategoryDelete = gql`
    mutation transactionCategoryDelete($input: TransactionCategoryDeleteInput!) {
        transactionCategoryDelete(input: $input) {
            transactionCategory {
                id,
                name,
            }
        }
    }
`
