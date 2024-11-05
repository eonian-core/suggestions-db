CREATE OR REPLACE FUNCTION update_token_email_if_empty(p_id UUID, p_email TEXT)
RETURNS VOID AS $$
BEGIN
  -- Set the search path to an empty string to enforce fully qualified names
  SET search_path TO '';

  IF p_email IS NOT NULL AND p_email <> '' THEN
    UPDATE public."Tokens"  -- Fully qualify the table name with the schema
    SET email = p_email
    WHERE id = p_id AND (email IS NULL OR email = '');
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
