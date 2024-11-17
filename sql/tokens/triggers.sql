CREATE TRIGGER notify_tokens
AFTER INSERT ON Tokens
FOR EACH ROW EXECUTE FUNCTION (
  PERFORM notify_slack('New record in Tokens: ' || NEW.token);
  RETURN NEW;
);