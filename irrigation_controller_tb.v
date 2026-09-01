`timescale 1ns/1ps

module irrigation_controller_tb;

    reg clk;
    reg reset;
    reg [7:0] soil_moisture;
    reg [7:0] temperature;
    reg [7:0] rain_level;

    wire irrigation;

    irrigation_controller uut (
        .clk(clk),
        .reset(reset),
        .soil_moisture(soil_moisture),
        .temperature(temperature),
        .rain_level(rain_level),
        .irrigation(irrigation)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        soil_moisture = 0;
        temperature = 0;
        rain_level = 0;

        #10;
        reset = 0;

        // Test Case 1: Dry soil, high temperature, no rain
        soil_moisture = 20;
        temperature = 40;
        rain_level = 10;
        #10;
        $display("Test 1: Moisture=%d Temperature=%d Rain=%d Irrigation=%b",
                 soil_moisture, temperature, rain_level, irrigation);

        // Test Case 2: Moist soil
        soil_moisture = 60;
        temperature = 40;
        rain_level = 10;
        #10;
        $display("Test 2: Moisture=%d Temperature=%d Rain=%d Irrigation=%b",
                 soil_moisture, temperature, rain_level, irrigation);

        // Test Case 3: High rain level
        soil_moisture = 20;
        temperature = 40;
        rain_level = 70;
        #10;
        $display("Test 3: Moisture=%d Temperature=%d Rain=%d Irrigation=%b",
                 soil_moisture, temperature, rain_level, irrigation);

        // Test Case 4: Low temperature
        soil_moisture = 20;
        temperature = 25;
        rain_level = 10;
        #10;
        $display("Test 4: Moisture=%d Temperature=%d Rain=%d Irrigation=%b",
                 soil_moisture, temperature, rain_level, irrigation);

        $finish;
    end

endmodule
