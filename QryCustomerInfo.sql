CREATE VIEW CustomerInfo AS
    SELECT * 
FROM OPENROWSET(
        BULK 'https://asadatalakeasc6g92.dfs.core.windows.net/wwi-02/customer-info/customerinfo.csv',
        FORMAT = 'CSV',
        PARSER_VERSION='2.0',
        FIRSTROW=2
    )
    WITH (
    [UserName] NVARCHAR (50),
    [Gender] NVARCHAR (10),
    [Phone] NVARCHAR (50),
    [Email] NVARCHAR (100),
    [CreditCard] NVARCHAR (50)
    ) AS [r];
    GO
 
SELECT * FROM CustomerInfo;
GO