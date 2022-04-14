IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'wwi-02_asadatalakeasc6g92_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [wwi-02_asadatalakeasc6g92_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://wwi-02@asadatalakeasc6g92.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE All2019Sales (
	[TransactionId] nvarchar(4000),
	[CustomerId] int,
	[ProductId] smallint,
	[Quantity] smallint,
	[Price] numeric(38,18),
	[TotalAmount] numeric(38,18),
	[TransactionDate] int,
	[ProfitAmount] numeric(38,18),
	[Hour] smallint,
	[Minute] smallint,
	[StoreId] smallint
	)
	WITH (
	LOCATION = 'sale-small/Year=2019/*/*/*/*.parquet',
	DATA_SOURCE = [wwi-02_asadatalakeasc6g92_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.All2019Sales
GO