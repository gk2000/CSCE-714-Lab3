//=====================================================================
// Project: 4 core MESI cache design
// File Name: cpu_transaction.sv
// Description: basic transaction class which is passed to the cpu agent and
// scoreboard
// Designers: Venky & Suru
//=====================================================================

//Enumerated type defined for request_type and access_cache_type

typedef enum bit {READ_REQ=0, WRITE_REQ=1} request_t;
typedef enum bit {ICACHE_ACC, DCACHE_ACC} access_cache_t;

//Lab3: TO DO: Extend cpu_transaction class from a uvm class
class cpu_transaction_c extends uvm_sequence_item;
    
    parameter DATA_WID_LV1      = `DATA_WID_LV1;
    parameter ADDR_WID_LV1      = `ADDR_WID_LV1;

//In the transaction class, below 4 class properties are needed. All class properties should be declared random.
//1.  request_type of type request_t
//2.  data of type bit(32 bit wide)
//3.  address of type bit(32 bit wide)
//4.  access_cache_type of type access_cache_t


    rand request_t                  request_type;
    rand bit [DATA_WID_LV1-1 : 0]   data;
    rand bit [ADDR_WID_LV1-1 : 0]   address;
    rand access_cache_t             access_cache_type;

//Lab3: TO DO: Add UVM macros for built in automation
    `uvm_object_utils_begin(cpu_transaction_c)
        `uvm_field_int(data, UVM_NOCOMPARE) //Adding UVM_NOCOMPARE to remove miscompare
        `uvm_field_int(address, UVM_NOCOMPARE) //Adding UVM_NOCOMPARE to remove miscompare
        `uvm_field_enum (request_t, request_type, UVM_NOCOMPARE) //Adding UVM_NOCOMPARE to remove miscompare
        `uvm_field_enum (access_cache_t, access_cache_type, UVM_ALL_ON) //Letting UVM_ALL_ON because it is not causing a miscompare
    `uvm_object_utils_end 

//Constraints on class properties which will be randomized
//Constraint 1: Set default access to I-cache.
    constraint ct_cache_type {
        soft access_cache_type == ICACHE_ACC;
    }

//Constraint 2: Set access_cache_type(either ICACHE_ACC or DCACHE_ACC) based on address bits.
//Read through HAS to figure out which addresses are meant for dcache access and icache access.
    constraint c_address_type {
        address[31:30] == 2'b0 -> access_cache_type == ICACHE_ACC;
        address[31:30] != 2'b0 -> access_cache_type == DCACHE_ACC;
    }
        
//Constraint 3: Soft constraint for expected data in case of a read type -> ignored in scoreboard
//This information is there in the README.md 
    constraint ct_exp_data{
        if((request_type == READ_REQ) && (address[3] == 1)) {
            soft data == 32'h5555_AAAA;
        }
        else if ((request_type == READ_REQ) && (address[3] == 0)) {
            soft data == 32'hAAAA_5555;
        }
    }

//Constructor
    function new (string name="cpu_transaction_c");
        super.new(name);
        $display("new object of class cpu_transaction_c is created");
    endfunction : new

endclass : cpu_transaction_c

