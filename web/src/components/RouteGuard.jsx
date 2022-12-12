import React, { Fragment } from 'react';
import { PropTypes } from 'prop-types';
import {
  useDispatch,
  useSelector
} from 'react-redux';
import { useNavigate } from 'react-router-dom';

import { checkTokenValid } from '../app/utils/checkTokenValid';
import { detach } from '../app/utils/detach';
import { logout } from '../app/slices/userSlice';
import { __notFoundPage } from '../pages/translations';

export const RouteGuard = ({ children, roles }) => {
  const dispatch = useDispatch();
  const userData = useSelector((state) => state.userData);
  const navigate = useNavigate();

  const tokenValid = checkTokenValid();
  if (!tokenValid) {
    detach(() => {
      dispatch(logout());
    });

    return (<></>);
  }

  const userRole = userData.role;
  const userHasAccess = roles.includes(userRole);

  if (userHasAccess) {
    return (
      <Fragment>
        {children}
      </Fragment>
    );
  } else {
    detach(() => {
      navigate(__notFoundPage.route.pageNotFound);
    });

    return (<></>);
  }
}

RouteGuard.propTypes = {
  children: PropTypes.object.isRequired,
  roles: PropTypes.array.isRequired,
};
