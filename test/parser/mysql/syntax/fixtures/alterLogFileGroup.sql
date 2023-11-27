-- https://dev.mysql.com/doc/refman/8.0/en/alter-logfile-group.html

/* ALTER LOGFILE GROUP logfile_group
    ADD UNDOFILE 'file_name'
    [INITIAL_SIZE [=] size]
    [WAIT]
    ENGINE [=] engine_name */


ALTER LOGFILE GROUP lg_3 ADD UNDOFILE 'undo_10.dat' INITIAL_SIZE=32M ENGINE=NDBCLUSTER;
ALTER LOGFILE GROUP lg_3 ADD UNDOFILE 'undo_10.dat' ENGINE=NDBCLUSTER;

ALTER LOGFILE GROUP lg_3 ADD UNDOFILE 'undo_10.dat' INITIAL_SIZE=32M WAIT ENGINE=NDBCLUSTER;
ALTER LOGFILE GROUP lg_3 ADD UNDOFILE 'undo_10.dat' WAIT ENGINE=NDBCLUSTER;
