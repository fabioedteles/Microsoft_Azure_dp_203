SELECT
    COUNT(*)
FROM
    OPENROWSET(
        BULK 'https://asadatalakeasc6g92.dfs.core.windows.net/wwi-02/sale-small/Year=2019/*/*/*/*',
        FORMAT='PARQUET'
    ) AS [r];