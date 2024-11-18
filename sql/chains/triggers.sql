DROP TRIGGER IF EXISTS notify_chains ON public."Chains";

CREATE OR REPLACE FUNCTION notify_chains_trigger()
RETURNS trigger AS $$
BEGIN
  PERFORM notify_slack('New suggested chains: ' || NEW.chain);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notify_chains
AFTER INSERT ON public."Chains"
FOR EACH ROW EXECUTE FUNCTION notify_chains_trigger();