import React from 'react';
import PropTypes from 'prop-types';

const style = {
  color: 'red',
  marginTop: -10,
  marginLeft: 8,
};

const FieldError = ({ message, show }) => {

  return (
    <p style={style}>{show && message}&nbsp;</p>
  );
};

FieldError.propTypes = {
  message: PropTypes.string,
  show: PropTypes.bool.isRequired,
};

export default FieldError;
