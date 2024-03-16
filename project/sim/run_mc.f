    +access+rwc                   //allow probes to record signals
    -timescale 1ns/1ns            //set simulation time precision
    -gui                          //launch user interface
    -input ../uvm/waves.tcl

//UVM options
    //+UVM_VERBOSITY=UVM_LOW

    //-uvmhome $UVMHOME

//file list containing design and TB files to compiled
    -f file_list.f
