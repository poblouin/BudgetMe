import {eachMonthOfInterval, format, getYear} from "date-fns";

export const monthsListFormatted = () => {
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