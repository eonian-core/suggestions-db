CREATE EXTENSION IF NOT EXISTS http;

CREATE OR REPLACE FUNCTION notify_slack(message TEXT)
RETURNS void AS $$
DECLARE
  webhook_url TEXT := current_setting('vault.WEBHOOK_URL');  -- Retrieve the webhook URL from the Vault
  payload JSON;
  response JSON;
BEGIN
  -- Construct the payload with the passed message
  payload := json_build_object('text', message);

  -- Send the payload to the Slack webhook
  response := http_post(webhook_url, payload);
END;
$$ LANGUAGE plpgsql;