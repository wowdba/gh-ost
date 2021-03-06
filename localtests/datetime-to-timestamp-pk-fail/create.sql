drop table if exists gh_ost_test;
create table gh_ost_test (
  id int unsigned auto_increment,
  i int not null,
  ts0 timestamp default current_timestamp,
  ts1 timestamp,
  dt2 datetime,
  t   datetime,
  updated tinyint unsigned default 0,
  primary key(id, t),
  key i_idx(i)
) auto_increment=1;

drop event if exists gh_ost_test;
delimiter ;;
create event gh_ost_test
  on schedule every 1 second
  starts current_timestamp
  ends current_timestamp + interval 60 second
  on completion not preserve
  enable
  do
begin
  insert into gh_ost_test values (null, 7, null, now(), now(), '2010-10-20 10:20:30', 0);

  insert into gh_ost_test values (null, 11, null, now(), now(), '2010-10-20 10:20:30', 0);
  update gh_ost_test set dt2=now() + interval 1 minute, updated = 1 where i = 11 order by id desc limit 1;

  insert into gh_ost_test values (null, 13, null, now(), now(), '2010-10-20 10:20:30', 0);
  update gh_ost_test set t=t + interval 1 minute, updated = 1 where i = 13 order by id desc limit 1;
end ;;
