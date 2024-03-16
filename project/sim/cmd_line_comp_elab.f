//testname undefined
//command line run
//coverage overwritten
    +access+rwc                   //allow probes to record signals
    -timescale 1ns/1ns            //set simulation time precision
    -elaborate                    //Compile and elab only, do not simulate
    -coverage A                   // record "all" coverage
    -covoverwrite                 // overwrite existing coverage db

//setup UVM home
    -uvmhome $UVMHOME

//file list containing design and TB files to compiled
    -f file_list.f
