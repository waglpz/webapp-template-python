import * as React from 'react';
import { PropTypes } from 'prop-types';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import {
  DatePicker,
  LocalizationProvider
} from '@mui/x-date-pickers';
import {
  isPast,
  isWeekend
} from 'date-fns';
import deLocale from 'date-fns/locale/de';
import { TextField } from '@mui/material';

const iso4y2m2d = (date) => {
  if (!date) {
    return;
  }
  const dateObject = new Date(date);
  const year = dateObject.getFullYear();
  const month = (dateObject.getMonth() + 1);
  const day = dateObject.getDate();
  const iso4y2m2d = `${year}-${month.toString().padStart(2, 0)}-${day.toString().padStart(2, 0)}`;

  return iso4y2m2d;
};

const DatePickerWrapper = ({style, label, value, disabled, availableDates, onChange}) => {

  const shouldDateBeDisabled = (date) => {
    if (availableDates && availableDates.length === 0) {
      return isWeekend(date);
    }

    if (availableDates && availableDates.length > 0) {
      const iso4y2m2d = iso4y2m2d(date);

      return !availableDates.includes(iso4y2m2d);
    }
    const weekend = isWeekend(date);
    const past = isPast(date);

        return (weekend || past);
    };

  const handleDatePickerChange = (date) => {
    const transformedDate = iso4y2m2d(date);
    onChange(transformedDate);
  };

  return (
    <div style={style}>
      <LocalizationProvider dateAdapter={AdapterDateFns} adapterLocale={deLocale}>
        <DatePicker
          label={label}
          value={value || null}
          shouldDisableDate={shouldDateBeDisabled}
          disabled={disabled}
          onChange={handleDatePickerChange}
          renderInput={(params) => <TextField {...params} />}
        />
      </LocalizationProvider>
    </div>
  );
};

DatePickerWrapper.propTypes = {
  style: PropTypes.object,
  label: PropTypes.string,
  value: PropTypes.string,
  disabled: PropTypes.bool,
  availableDates: PropTypes.array,
  onChange: PropTypes.func,
};

export default DatePickerWrapper;
