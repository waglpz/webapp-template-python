import { __dataTables } from '../__';

export default {
  textLabels: {
    body: {
      noMatch: __dataTables.noData,
    },
    pagination: {
      next: __dataTables.pagination.next,
        previous: __dataTables.pagination.previous,
        rowsPerPage: __dataTables.pagination.rowsPerPage,
        displayRows: __dataTables.pagination.displayRows,
    },
  },
  selectableRows: 'none',
  download: false,
  filter: false,
  search: false,
  viewColumns: false,
  print: false,
  serverSide: true,
  sortOrder: {},
  onTableChange: () => {},
}
