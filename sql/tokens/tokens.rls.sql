CREATE POLICY "Allow insert for anon users" on "public"."Tokens"
AS PERMISSIVE FOR INSERT
TO anon

WITH CHECK (true);
