CREATE TABLE Chains (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    chain TEXT,
    email TEXT
);
