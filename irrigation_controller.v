module irrigation_controller (
    input  wire clk,
    input  wire reset,
    input  wire [7:0] soil_moisture,
    input  wire [7:0] temperature,
    input  wire [7:0] rain_level,
    output reg irrigation
);

    // Threshold values
    parameter MOISTURE_THRESHOLD = 40;
    parameter TEMPERATURE_THRESHOLD = 35;
    parameter RAIN_THRESHOLD = 50;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            irrigation <= 1'b0;
        end
        else begin
            // Irrigation is required when soil is dry,
            // temperature is high and there is no significant rain.
            if ((soil_moisture < MOISTURE_THRESHOLD) &&
                (temperature > TEMPERATURE_THRESHOLD) &&
                (rain_level < RAIN_THRESHOLD))
                irrigation <= 1'b1;
            else
                irrigation <= 1'b0;
        end
    end

endmodule
