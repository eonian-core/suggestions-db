CREATE TRIGGER notify_tokens
AFTER INSERT ON Tokens
FOR EACH ROW EXECUTE FUNCTION (
  PERFORM notify_slack('New suggested tokens: ' || NEW.token);
  RETURN NEW;
);