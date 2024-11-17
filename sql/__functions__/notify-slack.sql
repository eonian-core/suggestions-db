CREATE EXTENSION IF NOT EXISTS http;

CREATE OR REPLACE FUNCTION notify_slack(message TEXT)
RETURNS void AS $$
DECLARE
  api_endpoint TEXT := current_setting('vault.SLACK_API_ENDPOINT');
  oauth_token TEXT := current_setting('vault.SLACK_OAUTH_TOKEN');
  channel TEXT := current_setting('vault.SLACK_CHANNEL');
  integration_enabled TEXT := current_setting('vault.SLACK_INTEGRATION_ENABLED');
  payload JSON;
  response JSON;
BEGIN
  IF integration_enabled = 'true' THEN
    payload := json_build_object(
      'channel', channel,
      'text', message
    );

    response := http_post(
      api_endpoint,
      payload,
      ARRAY[
        http_header('Content-Type', 'application/json'),
        http_header('Authorization', 'Bearer ' || oauth_token)
      ]
    );
  END IF;
END;
$$ LANGUAGE plpgsql;