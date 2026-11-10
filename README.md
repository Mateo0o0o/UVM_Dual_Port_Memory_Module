# Dual-Port Memory Module with UVM Verification
Hi! This project is a memory module with parameterizable address and data widths that supports read and write operations, featuring write priority whenever write and read operations are requested at the exact same time.

## Key Features
- **Write Priority Handling**: Automatically prioritizes writing over reading when both enable signals are active at the exact same time.
- **Dual-Port Functionality**: Separate interface signals allow clean control over memory access operations.
- **Parameterizable**: Address and Data Widths are completely parameterizable.
- **Verilator Ready**: Easy to simulate with Verilator (v5.052+). 
- **UVM Environment**: Automatically sends data, checks responses, and tracks testing coverage.

## Signal Pins
| Pin | Type | Description |
| :---: | :---: | ----------- |
| `rst_n` | Input | Resets the module (active low)|
| `wr_en` | Input | Write enable signal (set to 1 to write) |
| `rd_en` | Input | Read enable signal (set to 1 to read) |
| `addr` | Input | Target memory address for read or write |
| `wdata` | Input | Data to be written into memory |
| `rdata` | Output | Data read from the specified address |

## Transactions
1. **Write Operation**
To write data into memory:
- Set `wr_en` to HIGH (1).
- The `rd_en` is don't care.
- Provide the target address on `addr`.
- Provide the data to be saved on `wdata`.
2. **Read Operation**
- Set `rd_en` to HIGH (1).
- Ensure `wr_en` is LOW (0).
- Provide the address you want to read on `addr`.
- Read the output data from `rdata`.

## Tests Included
1. **Write-Read**: Writes data to an address, then reads it right back to see if it matches.
2. **Overwrite**: Writes data, overwrites it with new data, and checks if the newest data stays.
3. **Random Write/Read**: Randomly sends read and write operations across various memory addresses to test stability under stress.
4. **All Tests in Sequence**: Runs all 3 main tests one after another.
5. **All Tests in Random**: Randomly picks from the main three tests during each cycle to catch unexpected bugs.

## How to Run
1. Make sure you use Verilator v5.052 or above. See  [Verilator](https://verilator.org/guide/latest/install.html) for more information.
2. Give access to the vrun.py script using:
```chmod +x vrun.py```
3. Run the vrun script:

    *To run a single test*

    ```./vrun.py test=mem_test_wr coverage=1 wave```

    *To run all test simultaneously*
    
    ```./vrun.py run_all coverage=1 wave```
