//testname undefined
//command line run
    +access+rwc                   //allow probes to record signals
    -timescale 1ns/1ns            //set simulation time precision
    -R                            //use previously snapshot for simulation
    -coverage A                   // record "all" coverage
    -covoverwrite                 // overwrite existing coverage db
    -input ../uvm/waves.tcl

//UVM options
    +UVM_VERBOSITY=UVM_HIGH
