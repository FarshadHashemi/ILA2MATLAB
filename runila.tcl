
set ila [get_hw_ilas -of_objects [get_hw_devices xczu49dr_0] -filter {CELL_NAME=~"design_1_wrapperi/design_1_i/system_ila_0/inst/ila_lib"}]

set ila [get_hw_ilas -of_objects [get_hw_devices xczu49dr_1] -filter {CELL_NAME=~"ila_0_ins"}]

while {true} {
    run_hw_ila $ila
    wait_on_hw_ila $ila

    display_hw_ila_data [upload_hw_ila_data $ila]

    write_hw_ila_data -csv_file -force {C:\Users\f.hashemi\Desktop\iladata.csv} hw_ila_data_1
    after 1000
}
