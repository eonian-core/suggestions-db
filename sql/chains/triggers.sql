CREATE TRIGGER notify_chains
AFTER INSERT ON Chains
FOR EACH ROW EXECUTE FUNCTION (
  PERFORM notify_slack('New suggested chains: ' || NEW.chain);
  RETURN NEW;
);