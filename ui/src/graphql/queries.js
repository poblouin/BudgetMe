import { gql } from "graphql-tag"

export const transactions = gql`
    query transactions($from: ISO8601Date, $to: ISO8601Date) {
        transactions(from: $from, to: $to) {
            amount,
            date,
            merchantName,
            transactionCategory {
                name
            }
        }
    }
`