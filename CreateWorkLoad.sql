-- Drop objects if they exist
IF EXISTS (SELECT * FROM sys.workload_management_workload_classifiers WHERE [name] = 'HeavyLoader')
BEGIN
    DROP WORKLOAD CLASSIFIER HeavyLoader
END;
IF EXISTS (SELECT * FROM sys.workload_management_workload_groups WHERE name = 'BigDataLoad')
BEGIN
    DROP WORKLOAD GROUP BigDataLoad
END;
--Create workload group
CREATE WORKLOAD GROUP BigDataLoad WITH
  (
      MIN_PERCENTAGE_RESOURCE = 50, -- integer value
      REQUEST_MIN_RESOURCE_GRANT_PERCENT = 25, --  (guaranteed min 4 concurrency)
      CAP_PERCENTAGE_RESOURCE = 100
  );
-- Create workload classifier
CREATE WORKLOAD Classifier HeavyLoader WITH
(
    Workload_Group ='BigDataLoad',
    MemberName='asa.sql.import01',
    IMPORTANCE = HIGH
);
-- View classifiers
SELECT * FROM sys.workload_management_workload_classifiers