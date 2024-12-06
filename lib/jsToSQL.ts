export default function convertToSQLDate(date: Date | null) {
  if (!date || !(date instanceof Date) || isNaN(date.getTime())) {
    return null;
  }
  return date.toISOString().slice(0, 19).replace("T", " ");
}
