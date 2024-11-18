DROP TRIGGER IF EXISTS notify_tokens ON public."Tokens";

CREATE OR REPLACE FUNCTION notify_tokens_trigger()
RETURNS trigger AS $$
BEGIN
  PERFORM notify_slack('New suggested tokens: ' || NEW.token);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notify_tokens
AFTER INSERT ON public."Tokens"
FOR EACH ROW EXECUTE FUNCTION notify_tokens_trigger();