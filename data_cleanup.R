# Dataset Creation

# Read full dataset
btc.full = read_parquet("data/train.parquet.gzip")
# Only get BTC asset rows
btc.full <- btc.full %>% filter(Asset_ID==1)
summary(btc.full)
as_datetime(head(btc.full$timestamp, n=1))
as_datetime(tail(btc.full$timestamp, n=1))

# Create Training Set for 3 month period
btc.train = subset(btc.full, timestamp > as.POSIXct("2021-02-28 23:59:00", tz="GMT") & timestamp < as.POSIXct("2021-06-01 00:00:00", tz="GMT"))
as_datetime(head(btc.train$timestamp, n=1))
as_datetime(tail(btc.train$timestamp, n=1))
head(btc.train)

btc.short = subset(btc.full, timestamp > as.POSIXct("2021-05-31 23:59:00", tz="GMT") & timestamp < as.POSIXct("2021-06-02 00:00:00", tz="GMT"))
as_datetime(head(btc.short$timestamp, n=1))
as_datetime(tail(btc.short$timestamp, n=1))
head(btc.short)

btc.long = subset(btc.full, timestamp > as.POSIXct("2021-05-31 23:59:00", tz="GMT") & timestamp < as.POSIXct("2021-06-08 00:00:00", tz="GMT"))
as_datetime(head(btc.long$timestamp, n=1))
as_datetime(tail(btc.long$timestamp, n=1))

write_parquet(btc.train, "data/btc-train.parquet")
write_parquet(btc.short, "data/btc-test-short.parquet")
write_parquet(btc.long, "data/btc-test-long.parquet")