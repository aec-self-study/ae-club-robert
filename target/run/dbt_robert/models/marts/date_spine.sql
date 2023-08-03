

  create or replace view `aec-students`.`dbt_robert`.`date_spine`
  OPTIONS()
  as {date_spine(
    "day",
    "to_date('01/01/2023', 'mm/dd/yyyy')",
    "dbt.dateadd(week, 1, current_date)"
)};

