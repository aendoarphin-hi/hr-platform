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

/**
 * Formats a timestamp into a human-readable string.
 * @param {string} timestamp - timestamp string
 * @returns {string} formatted string
 */
export function formatTimeAgo(timestamp) {
  const now = new Date();
  const then = new Date(timestamp);
  const diffMins = Math.floor((now - then) / 60000);

  if (diffMins < 1) return "Just now";
  if (diffMins < 60) return `${diffMins} minute${diffMins !== 1 ? "s" : ""} ago`;

  const diffHours = Math.floor(diffMins / 60);
  if (diffHours < 24) return `${diffHours} hour${diffHours !== 1 ? "s" : ""} ago`;

  const diffDays = Math.floor(diffHours / 24);
  if (diffDays < 30) return `${diffDays} day${diffDays !== 1 ? "s" : ""} ago`;

  return then.toLocaleDateString(undefined, { month: "short", day: "numeric", year: "numeric" });
}
