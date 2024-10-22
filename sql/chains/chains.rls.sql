CREATE POLICY "Allow insert for anon users" on "public"."Chains"
AS PERMISSIVE FOR INSERT
TO anon

WITH CHECK (true);
