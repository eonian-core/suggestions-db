ALTER TABLE heartbeat ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow insert for anon users"
ON public.heartbeat
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (true);

CREATE POLICY "Deny select for anon users"
ON public.heartbeat
FOR SELECT
TO anon
USING (false);