import * as React from 'react';
import Button from '@mui/material/Button';
import ButtonGroup from '@mui/material/ButtonGroup';
import ArrowDropDownIcon from '@mui/icons-material/ArrowDropDown';
import ClickAwayListener from '@mui/material/ClickAwayListener';
import Grow from '@mui/material/Grow';
import Paper from '@mui/material/Paper';
import Popper from '@mui/material/Popper';
import PropTypes from 'prop-types';

export default function SplitButton ({ label, buttonOptions }) {
  const [open, setOpen] = React.useState(false);
  const [options, setOptions] = React.useState(false);
  const anchorRef = React.useRef(null);
  
  React.useEffect(() => {
    buttonOptions.sort((a, b) => (a.disabled ? 1 : 0) > (b.disabled ? 1 : 0) )
    setOptions(buttonOptions);
  }, [buttonOptions]);
  
  const handleMenuItemClick = (event, index, onClick) => {
    setOpen(false);
    onClick();
  };

  const handleToggle = () => {
    setOpen((prevOpen) => !prevOpen);
  };

  const handleClose = (event) => {
    if (anchorRef.current && anchorRef.current.contains(event.target)) {
      return;
    }

    setOpen(false);
  };

  return (
    <React.Fragment>
      <ButtonGroup variant="contained" ref={anchorRef} aria-label="split button" disabled={open}>
        <Button
          aria-controls={open ? 'split-button-menu' : undefined}
          aria-expanded={open ? 'true' : undefined}
          aria-label=""
          aria-haspopup="menu"
          onClick={handleToggle}
        >
          {label}
          <ArrowDropDownIcon/>
        </Button>
      </ButtonGroup>
      <Popper
        sx={{
          zIndex: 1,
        }}
        open={open}
        anchorEl={anchorRef.current}
        role={undefined}
        transition
        disablePortal
      >
        {({ TransitionProps, placement }) => (
          <Grow
            {...TransitionProps}
            style={{
              transformOrigin:
                placement !== 'bottom' ? 'center top' : 'center bottom',
            }}
          >
            <Paper sx={{ marginRight: 2 }}>
              <ClickAwayListener onClickAway={handleClose}>
                <ButtonGroup sx={{ boxShadow: 5, p: 0, m: 0, marginTop: -8, background: 'transparent' }}
                             orientation="vertical"
                             aria-label="vertical outlined button group"
                >
                  {options.map((option, index) => (
                    <Button variant='contained'
                            style={{justifyContent: "flex-start"}}
                            key={option.label}
                            disabled={option.disabled}
                            onClick={(event) => handleMenuItemClick(event, index, option.onClick)}
                    >
                      {option.icon}&nbsp;{option.label}
                    </Button>
                  ))}
                </ButtonGroup>
              </ClickAwayListener>
            </Paper>
          </Grow>
        )}
      </Popper>
    </React.Fragment>
  );
}

SplitButton.propTypes = {
  buttonOptions: PropTypes.array.isRequired,
  label: PropTypes.string.isRequired,
};
