import React, { useState, useEffect, useRef, Fragment } from 'react';
import { render } from 'react-dom';
import GraphiQL from 'graphiql';
import GraphiQLExplorer from 'graphiql-explorer';
import { buildClientSchema, getIntrospectionQuery } from 'graphql';

const DEFAULT_QUERY = `{\n}`;

const GraphiqlExplorer = ({ selectedApi, allApis, setSelectedApi, headers, setHeaders }) => {
  const [schema, setSchema] = useState(null);
  const [query, setQuery] = useState(DEFAULT_QUERY);
  const [explorerIsOpen, setExplorerIsOpen] = useState(false);
  const [loadingSchema, setLoadingSchema] = useState(true);
  const [queryResponse, setQueryResponse] = useState(null);
  let graphiqlRef = useRef(null);

  const fetcher = (params) => {
    return fetch(selectedApi.url, {
      method: 'POST',
      headers: Object.assign(
        { 'Content-Type': 'application/json' },
        headers
      ),
      body: JSON.stringify(params),
    })
      .then((response) => {
        return response.text();
      })
      .then((responseBody) => {
        try {
          const body = JSON.parse(responseBody);
          setQueryResponse(body);
          return body;
        } catch (e) {
          return responseBody;
        }
      });
  };

  const getSchema = () => {
    return fetcher({
      query: getIntrospectionQuery(),
    }).then((result) => {
      if(result && result.error){
        return;
      }
      setSchema(buildClientSchema(result.data));
    });
  }

  useEffect(() => {
    setLoadingSchema(true);
    getSchema()
      .then(() => setLoadingSchema(false));
  }, [selectedApi]);

  useEffect(() => {
    if (queryResponse && queryResponse.error && !schema && Object.keys(headers).length > 0) {
      getSchema();
    }
  }, [schema, headers])

  const changeQuery = (query) => setQuery(query);

  const toggleExplorer = () => setExplorerIsOpen(!explorerIsOpen);

  const handleHeaderEdit = (headerStr) => {
    try {
      const tempHeaders = JSON.parse(headerStr);
      setHeaders(tempHeaders);
    } catch (error) {
      return
    }
  }

  return (
    <Fragment>
      <div className={`graphiql-container ${loadingSchema && 'blur'}`}>
        <GraphiQLExplorer
          schema={schema}
          query={query}
          onEdit={changeQuery}
          onRunOperation={(operationName) =>
            graphiqlRef.handleRunQuery(operationName)
          }
          explorerIsOpen={explorerIsOpen}
          onToggleExplorer={toggleExplorer}
        />
        <GraphiQL
          ref={(ref) => (graphiqlRef = ref)}
          fetcher={fetcher}
          schema={schema}
          query={query}
          onEditQuery={changeQuery}
          headerEditorEnabled={true}
          onEditHeaders={handleHeaderEdit}
        >
          <GraphiQL.Logo>{selectedApi.name}</GraphiQL.Logo>
          <GraphiQL.Toolbar>
            <GraphiQL.Button
              onClick={() => graphiqlRef.handlePrettifyQuery()}
              label="Prettify"
              title="Prettify Query"
            />
            <GraphiQL.Button
              onClick={() => graphiqlRef.handleToggleHistory()}
              label="History"
              title="Show History"
            />
            <GraphiQL.Button
              onClick={toggleExplorer}
              label="Explorer"
              title="Toggle Explorer"
            />
            {allApis.length > 1 && (
              <GraphiQL.Menu label="Select Api" title="Select Api">
                {allApis.map((api) => (
                  <GraphiQL.MenuItem
                    onSelect={() => setSelectedApi(api)}
                    title={api.name}
                    label={api.name}
                  />
                ))}
              </GraphiQL.Menu>
            )}
          </GraphiQL.Toolbar>
        </GraphiQL>
      </div>
    </Fragment>
  );
};

const TykGraphql = ({ config }) => {
  const { schemaUrls } = config;
  const [selectedApi, setSelectedApi] = useState(schemaUrls[0]);
  const [headers, setHeaders] = useState('');

  return (
    <GraphiqlExplorer
      selectedApi={selectedApi}
      allApis={schemaUrls}
      setSelectedApi={setSelectedApi}
      headers={headers}
      setHeaders={setHeaders}
    />
  );
};

class GraphiqlInit {
  constructor(config) {
    const { containerId } = config;
    localStorage.setItem('graphiql:historyPaneOpen', false);
    localStorage.setItem('graphiql:query', "");
    localStorage.setItem('graphiql:docExplorerOpen', false);
    render(
      <TykGraphql config={config} />,
      document.getElementById(containerId)
    );
  }
}
window.GraphiqlInit = GraphiqlInit;