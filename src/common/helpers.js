export function debounce() { // fix for resize observer error
  // Define debounce function
  const debounce = (fn, delay) => {
    let timer;
    return (...args) => {
      if (timer) {
        clearTimeout(timer);
      }
      timer = setTimeout(() => {
        fn(...args);
      }, delay);
    };
  };

  // Override global ResizeObserver
  const _ResizeObserver = window.ResizeObserver;
  window.ResizeObserver = class ResizeObserver extends _ResizeObserver {
    constructor(callback) {
      super(debounce(callback, 20)); // 20ms delay
    }
  };
}

/**
 * Filters an array of items by a field value.
 * @param {Array} items - source array
 * @param {string} field - item field to compare
 * @param {*} value - filter value (falsy values return items unchanged)
 * @param {string} mode - "eq" for exact match, "includes" for substring match
 * @returns {Array} filtered array
 */
export function filterByField(items, field, value, mode = "eq") {
  if (!value) return items;
  const needle = value.toLowerCase();
  return items.filter((item) => {
    const haystack = String(item[field] ?? "").toLowerCase();
    return mode === "includes" ? haystack.includes(needle) : haystack === needle;
  });
}

/**
 * Sorts an array of items by a field value.
 * @param {Array} items - source array
 * @param {string} column - item field to sort by
 * @param {boolean} desc - true for descending order
 * @returns {Array} sorted array
 */
export function sortByField(items, column, desc = false) {
  return items.sort((a, b) => {
    if (a[column] === b[column]) return 0;
    return desc
      ? a[column] < b[column]
        ? 1
        : -1
      : a[column] > b[column]
        ? 1
        : -1;
  });
}

/**
 * Filters an array of objects by a search term.
 * @param {Array} list - source array
 * @param {string} term - search term
 * @returns {Array} filtered array
 */
export function searchByText(list, term) {
  const t = term.trim().toLowerCase();
  if (!t) return list;
  return list.filter((item) => JSON.stringify(item).toLowerCase().includes(t));
}
