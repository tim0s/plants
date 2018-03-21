EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L D D1
U 1 1 5A9FAB50
P 4650 3550
F 0 "D1" H 4650 3650 50  0000 C CNN
F 1 "D" H 4650 3450 50  0000 C CNN
F 2 "Diodes_THT:D_DO-27_P12.70mm_Horizontal" H 4650 3550 50  0001 C CNN
F 3 "" H 4650 3550 50  0001 C CNN
	1    4650 3550
	0    1    1    0   
$EndComp
$Comp
L Motor_DC M1
U 1 1 5A9FAC48
P 5050 3500
F 0 "M1" H 5150 3600 50  0000 L CNN
F 1 "Motor_DC" H 5150 3300 50  0000 L TNN
F 2 "Connectors_Terminal_Blocks:TerminalBlock_Pheonix_PT-3.5mm_2pol" H 5050 3410 50  0001 C CNN
F 3 "" H 5050 3410 50  0001 C CNN
	1    5050 3500
	1    0    0    -1  
$EndComp
$Comp
L Q_NPN_BCE Q1
U 1 1 5A9FAD3C
P 4950 4100
F 0 "Q1" H 5150 4150 50  0000 L CNN
F 1 "Q_NPN_BCE" H 5150 4050 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-126_Vertical" H 5150 4200 50  0001 C CNN
F 3 "" H 4950 4100 50  0001 C CNN
	1    4950 4100
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5A9FAE28
P 4400 4100
F 0 "R1" V 4480 4100 50  0000 C CNN
F 1 "330" V 4400 4100 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 4330 4100 50  0001 C CNN
F 3 "" H 4400 4100 50  0001 C CNN
	1    4400 4100
	0    1    1    0   
$EndComp
Wire Wire Line
	4550 4100 4750 4100
Wire Wire Line
	5050 3900 5050 3800
Wire Wire Line
	4650 3400 4650 3150
Wire Wire Line
	4650 3150 5050 3150
Wire Wire Line
	5050 3150 5050 3300
Wire Wire Line
	4650 3700 4650 3800
Wire Wire Line
	4650 3800 5050 3800
$Comp
L GND #PWR01
U 1 1 5A9FC12F
P 5050 4500
F 0 "#PWR01" H 5050 4250 50  0001 C CNN
F 1 "GND" H 5050 4350 50  0000 C CNN
F 2 "" H 5050 4500 50  0001 C CNN
F 3 "" H 5050 4500 50  0001 C CNN
	1    5050 4500
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR02
U 1 1 5A9FC14B
P 4850 3000
F 0 "#PWR02" H 4850 2850 50  0001 C CNN
F 1 "VCC" H 4850 3150 50  0000 C CNN
F 2 "" H 4850 3000 50  0001 C CNN
F 3 "" H 4850 3000 50  0001 C CNN
	1    4850 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3000 4850 3150
Connection ~ 4850 3150
Wire Wire Line
	5050 4500 5050 4300
Text GLabel 4050 4100 0    60   Input ~ 0
PWM
Wire Wire Line
	4050 4100 4250 4100
$Comp
L D D2
U 1 1 5A9FC93F
P 6700 3600
F 0 "D2" H 6700 3700 50  0000 C CNN
F 1 "D" H 6700 3500 50  0000 C CNN
F 2 "Diodes_THT:D_DO-27_P12.70mm_Horizontal" H 6700 3600 50  0001 C CNN
F 3 "" H 6700 3600 50  0001 C CNN
	1    6700 3600
	0    1    1    0   
$EndComp
$Comp
L Motor_DC M2
U 1 1 5A9FC946
P 7100 3550
F 0 "M2" H 7200 3650 50  0000 L CNN
F 1 "Motor_DC" H 7200 3350 50  0000 L TNN
F 2 "Connectors_Terminal_Blocks:TerminalBlock_Pheonix_PT-3.5mm_2pol" H 7100 3460 50  0001 C CNN
F 3 "" H 7100 3460 50  0001 C CNN
	1    7100 3550
	1    0    0    -1  
$EndComp
$Comp
L Q_NPN_BCE Q2
U 1 1 5A9FC94D
P 7000 4150
F 0 "Q2" H 7200 4200 50  0000 L CNN
F 1 "Q_NPN_BCE" H 7200 4100 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-126_Vertical" H 7200 4250 50  0001 C CNN
F 3 "" H 7000 4150 50  0001 C CNN
	1    7000 4150
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5A9FC954
P 6450 4150
F 0 "R2" V 6530 4150 50  0000 C CNN
F 1 "330" V 6450 4150 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 6380 4150 50  0001 C CNN
F 3 "" H 6450 4150 50  0001 C CNN
	1    6450 4150
	0    1    1    0   
$EndComp
Wire Wire Line
	6600 4150 6800 4150
Wire Wire Line
	7100 3950 7100 3850
Wire Wire Line
	6700 3450 6700 3200
Wire Wire Line
	6700 3200 7100 3200
Wire Wire Line
	7100 3200 7100 3350
Wire Wire Line
	6700 3750 6700 3850
Wire Wire Line
	6700 3850 7100 3850
$Comp
L GND #PWR03
U 1 1 5A9FCE9C
P 7100 4600
F 0 "#PWR03" H 7100 4350 50  0001 C CNN
F 1 "GND" H 7100 4450 50  0000 C CNN
F 2 "" H 7100 4600 50  0001 C CNN
F 3 "" H 7100 4600 50  0001 C CNN
	1    7100 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 4350 7100 4600
Text GLabel 6150 4150 0    60   Input ~ 0
PWM2
Wire Wire Line
	6150 4150 6300 4150
$Comp
L VCC #PWR04
U 1 1 5A9FCF0A
P 6900 2950
F 0 "#PWR04" H 6900 2800 50  0001 C CNN
F 1 "VCC" H 6900 3100 50  0000 C CNN
F 2 "" H 6900 2950 50  0001 C CNN
F 3 "" H 6900 2950 50  0001 C CNN
	1    6900 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 2950 6900 3200
Connection ~ 6900 3200
$Comp
L VCC #PWR05
U 1 1 5A9FD263
P 9300 3900
F 0 "#PWR05" H 9300 3750 50  0001 C CNN
F 1 "VCC" H 9300 4050 50  0000 C CNN
F 2 "" H 9300 3900 50  0001 C CNN
F 3 "" H 9300 3900 50  0001 C CNN
	1    9300 3900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5A9FD287
P 9600 3850
F 0 "#PWR06" H 9600 3600 50  0001 C CNN
F 1 "GND" H 9600 3700 50  0000 C CNN
F 2 "" H 9600 3850 50  0001 C CNN
F 3 "" H 9600 3850 50  0001 C CNN
	1    9600 3850
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG07
U 1 1 5A9FD2AB
P 9600 3700
F 0 "#FLG07" H 9600 3775 50  0001 C CNN
F 1 "PWR_FLAG" H 9600 3850 50  0000 C CNN
F 2 "" H 9600 3700 50  0001 C CNN
F 3 "" H 9600 3700 50  0001 C CNN
	1    9600 3700
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG08
U 1 1 5A9FD2CF
P 9300 4050
F 0 "#FLG08" H 9300 4125 50  0001 C CNN
F 1 "PWR_FLAG" H 9300 4200 50  0000 C CNN
F 2 "" H 9300 4050 50  0001 C CNN
F 3 "" H 9300 4050 50  0001 C CNN
	1    9300 4050
	-1   0    0    1   
$EndComp
Wire Wire Line
	9600 3850 9600 3700
Wire Wire Line
	9300 3900 9300 4050
Text GLabel 9550 5350 0    60   Input ~ 0
PWM
Text GLabel 9550 4900 0    60   Input ~ 0
PWM2
$Comp
L PWR_FLAG #FLG09
U 1 1 5A9FD41E
P 9750 5350
F 0 "#FLG09" H 9750 5425 50  0001 C CNN
F 1 "PWR_FLAG" H 9750 5500 50  0000 C CNN
F 2 "" H 9750 5350 50  0001 C CNN
F 3 "" H 9750 5350 50  0001 C CNN
	1    9750 5350
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG010
U 1 1 5A9FD442
P 9750 4900
F 0 "#FLG010" H 9750 4975 50  0001 C CNN
F 1 "PWR_FLAG" H 9750 5050 50  0000 C CNN
F 2 "" H 9750 4900 50  0001 C CNN
F 3 "" H 9750 4900 50  0001 C CNN
	1    9750 4900
	0    1    1    0   
$EndComp
Wire Wire Line
	9550 4900 9750 4900
Wire Wire Line
	9550 5350 9750 5350
$EndSCHEMATC
