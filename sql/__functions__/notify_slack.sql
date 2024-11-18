CREATE EXTENSION IF NOT EXISTS http;

CREATE OR REPLACE FUNCTION notify_slack(message TEXT)
RETURNS BOOLEAN AS $$
DECLARE
  api_endpoint TEXT;
  oauth_token TEXT;
  channel TEXT;
  integration_enabled TEXT;
  payload TEXT;
  response http_response;
BEGIN
  SELECT
    MAX(CASE WHEN name = 'SLACK_API_ENDPOINT' THEN decrypted_secret END),
    MAX(CASE WHEN name = 'SLACK_OAUTH_TOKEN' THEN decrypted_secret END),
    MAX(CASE WHEN name = 'SLACK_CHANNEL' THEN decrypted_secret END),
    MAX(CASE WHEN name = 'SLACK_INTEGRATION_ENABLED' THEN decrypted_secret END)
  INTO api_endpoint, oauth_token, channel, integration_enabled
  FROM vault.decrypted_secrets
  WHERE name IN ('SLACK_API_ENDPOINT', 'SLACK_OAUTH_TOKEN', 'SLACK_CHANNEL', 'SLACK_INTEGRATION_ENABLED');

  IF integration_enabled = 'true' THEN
    payload := format('{"channel": %L, "text": %L}', channel, message);

    response := http((
      'POST',
      api_endpoint,
      ARRAY[
        http_header('Content-Type', 'application/json'),
        http_header('Authorization', oauth_token)
      ],
      'application/json',
      payload
    )::http_request);

    IF response.content::jsonb->>'ok' = 'true' THEN
      RETURN true;
    ELSE
      RAISE LOG 'Message: %, Error: %', message, response.content::jsonb->>'error';
    END IF;
  END IF;

  RETURN false;
END;
$$ LANGUAGE plpgsql;