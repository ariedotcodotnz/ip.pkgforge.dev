-- Database schema for visitor logs
CREATE TABLE IF NOT EXISTS visitor_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp TEXT NOT NULL,
    ip TEXT,
    path TEXT NOT NULL,
    user_agent TEXT,
    referrer TEXT,
    accept_language TEXT,
    cf_connecting_ip TEXT,
    cf_ipcountry TEXT,
    cf_ray TEXT,
    x_real_ip TEXT,
    x_forwarded_for TEXT,
    city TEXT,
    country TEXT,
    region TEXT,
    latitude TEXT,
    longitude TEXT,
    org TEXT,
    timezone TEXT,
    method TEXT,
    host TEXT,
    query_string TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster queries
CREATE INDEX IF NOT EXISTS idx_timestamp ON visitor_logs(timestamp);
CREATE INDEX IF NOT EXISTS idx_path ON visitor_logs(path);
CREATE INDEX IF NOT EXISTS idx_ip ON visitor_logs(ip);