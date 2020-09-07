import React from 'react';
import { HashRouter as Router, Switch, Route } from 'react-router-dom';

import { Main } from './components/main/index';
import Auth from './components/auth/auth';
import Toppage from './components/top/index';
import Signin from './components/auth/signin';
import Signup from './components/auth/signup';
import Room from './components/room/room';

const Notfound = () => (
  <div> 404 not found</div>
);

const Root = () => (
  <Router>
    <Switch>
      <Route exact path="/signin" render={() => <Signin />} />
      <Route exact path="/signup" render={() => <Signup />} />
      <Route exact path="/toppage" render={() => <Toppage />} />
      <Auth>
        <Switch>
          <Route exact path="/" render={() => <Main />} />
          <Route exact path="/rooms/:id" render={() => <Room />} />
        </Switch>
      </Auth>
      <Route component={Notfound} />
    </Switch>
  </Router>
);

export default Root;
