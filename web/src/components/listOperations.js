export function applyCurrentPageData(data, defaultTableOptions, options) {
  const {totalElements, size, _embedded: elements} = data;
  const updatedTableOptions = {
    ...defaultTableOptions,
    count: totalElements,
    rowsPerPage: size,
  };
  if (options.page) {
    updatedTableOptions.page = (options.page - 1);
  }
  return {elements, updatedTableOptions};
}
