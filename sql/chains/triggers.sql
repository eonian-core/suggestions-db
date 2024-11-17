CREATE TRIGGER notify_chains
AFTER INSERT ON Chains
FOR EACH ROW EXECUTE FUNCTION (
  PERFORM notify_slack('New record in Chains: ' || NEW.chain);
  RETURN NEW;
);