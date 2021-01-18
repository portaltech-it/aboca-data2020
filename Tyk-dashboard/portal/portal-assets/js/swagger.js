import "@babel/polyfill";
import React from 'react';
import ReactDOM from 'react-dom';
import { fromJS } from 'immutable';
import 'jquery';
import SwaggerUI from 'swagger-ui';
import StandalonePreset from 'swagger-ui/dist/swagger-ui-standalone-preset'
var yamlFront = require('yaml-front-matter');

window.SwaggerUI = SwaggerUI;
window.StandalonePreset = StandalonePreset;

class TykSwaggerUI {
  constructor(config) {
    this.config = config;
    this.getSwaggerDefinition(config.url).then((rsp) => {
      if(typeof rsp === 'object') {
        this.swaggerDefinition = rsp;
      } else if(this.isJsonString(rsp)) {
        this.swaggerDefinition = JSON.parse(rsp);
      } else {
        let definition = yamlFront.safeLoadFront('---\n' + rsp + '\n---');
        this.swaggerDefinition = definition;
      }

      this.swaggerDefinition.url = config.url;
      this.initSwagger();
    });
  }

  isJsonString(str) {
    let json = false;
    try {
      json = JSON.parse(str);
    } catch (e) {
      return json;
    }
    return json;
  }

  initSwagger() {
    let addHostPlugin = this.addHostPlugin.bind(this);

    this.swaggerUI = SwaggerUI({
      deepLinking: false,
      dom_id: this.config.container,
      layout: 'BaseLayout',
      docExpansion: "none",
      sorter: "alpha",
      presets: [
        SwaggerUI.presets.apis
      ],
      plugins: [
       SwaggerUI.plugins.DownloadUrl,
       StandalonePreset,
       addHostPlugin
      ],
      spec: this.swaggerDefinition
    });
  }

  getSwaggerDefinition(url) {
    return $.ajax({
      method: "GET",
      url: url
    });
  }

  addHostPlugin(system) {
    let rawUrl = this.config.url;
    return {
      wrapComponents: {
        info: (Original, system) => class WrappedInfoDisplay extends React.Component {
          constructor(props) {
            super(props);

            this.swaggerVersion = system.getState().getIn(['spec', 'resolved', 'openapi']);
            this.handleHost = this.handleHost.bind(this);
            this.handleChange = this.handleChange.bind(this);
            this.buttonText = (this.swaggerVersion === '3.0.0') ? 'Add Server' : 'Update host';
            this.buttonLabel = (this.swaggerVersion === '3.0.0') ? 'Add Server' : 'Change Base url';

            this.state = {
              v3: {
                invalid: false,
                submitted: false
              },
              v2: {
                invalid: false,
                submitted: false
              },
              value: (this.swaggerVersion === '3.0.0') ? '' : this.props.host + this.props.basePath
            };
          }

          handleChange(event) {
            this.setValue(event.target.value);
          }

          setValue(value) {
            this.setState({ value });
          }

          updateHost(value) {
            let url = value.split('/');
            let host = url[0];
            let basePath = url[1] ? ('/' + url[1]) : '';

            system.specActions.updateHost({
              host,
              basePath
            });
          }

          isValidHost() {
            return this.state.value.match(/^https?:\/\/[\-\w]+(\.[\-\w]+)*(:[0-9]+)?\/?(\/[.\-\w]*)*$/);
          }

          handleHost(event) {
            event.preventDefault();
            if(this.swaggerVersion === '3.0.0') {
              if(this.isValidHost()) {
                system.specActions.addHost(this.state.value);
                this.setValue('');
                this.setState({
                  v3: {
                    invalid: false,
                    submitted: true
                  }
                });
              } else {
                this.setState({
                  v3: {
                    invalid: true,
                    submitted: true
                  }
                });
              }
            } else {
              if(this.state.value) {
                this.updateHost(this.state.value);
                this.setState({
                  v2: {
                    invalid: false,
                    submitted: true
                  }
                });
              } else {
                this.setState({
                  v2: {
                    invalid: true,
                    submitted: true
                  }
                });
              }
            }
          }

          getInputClass() {
            let classes = [];

            if(this.state.v3.invalid || this.state.v2.invalid) {
              classes.push('invalid');
            }

            return classes.join(' ');
          }

          render() {
            let Input = system.getComponents().Input;
            let Button = system.getComponents().Button;
            let newProps = Object.assign({}, this.props, {url: rawUrl });
            return <div className="swagger-host-manager">
              <Original {...newProps} />
              <form onSubmit={this.handleHost}>
                <div className="scheme-container">
                  <section className="schemes wrapper block col-12 servers-wrapper">
                    <label htmlFor="schemes" className="custom-url">
                      <span className="schemes-title">{ this.buttonLabel }</span>
                      <Input className={ this.getInputClass() } placeholder="http://localhost" onChange={ this.handleChange } value={ this.state.value } type="text" />
                    </label>
                    <button className="btn try-out__btn" type="submit">{ this.buttonText }</button>
                    {
                      this.state.v3.submitted
                        ? this.state.v3.invalid
                            ? <div className="text-danger swagger-message">Please enter a valid host server</div>
                            : <div className="text-success swagger-message">Server has been added successfully. Please select it from servers list!</div>
                        : null
                    }
                    {
                      this.state.v2.submitted
                        ? this.state.v2.invalid
                            ? <div className="text-danger swagger-message">Please enter a valid host server</div>
                            : <div className="text-success swagger-message">Host has been successfully updated!</div>
                        : null
                    }
                  </section>
                </div>
              </form>
            </div>
          }
        }
      },
      statePlugins: {
        spec: {
          actions: {
            updateHost: function(str) {
              return {
                type: "UPDATE_HOST",
                payload: str
              };
            },
            addHost: function(str) {
              return {
                type: "ADD_HOST",
                payload: str
              };
            }
          },
          reducers: {
            "UPDATE_HOST": function(state, action) {
              state = state
                .setIn(['resolved', 'host'], action.payload.host)
                .setIn(['resolved', 'basePath'], action.payload.basePath);
              return state;
            },
            "ADD_HOST": function(state, action) {
              let servers = state.getIn(['resolved', 'servers']);
              servers = servers.unshift(fromJS({
                url: action.payload
              }));

              state = state
                .setIn(['resolved', 'servers'], servers);
              return state;
            }
          }
        }
      }
    };
  }
}

window.TykSwaggerUI = TykSwaggerUI;
