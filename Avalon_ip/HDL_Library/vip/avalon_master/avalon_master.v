module avalon_master(
    address,
    read,
    write,
    readdata,
    writedata,
    waitrequest,
);
    
    initial begin
        /*
            create your sequence
        */
    end
    avalon_driver avalon_driver_inst(
        .address    (),
        .read       (),
        .write      (),
        .readdata   (),
        .writedata  (),
        .waitrequest(),
        .valid      (),
        .ready      ()
    );
endmodule