DE2_70_Synthesizer
------

This demonstration shows how to implement a Multi-tone Electronic Keyboard using DE2-70 board with a PS/2 Keyboard and a speaker.

Running the Design
------------------

1) Connect a PS/2 Keyboard to the DE2-70 board
2) Connect the VGA output of the DE2-70 board to a VGA monitor (both LCD and CRT type of monitors should work)
3) Connect the Lineout of the DE2-70 board to a speaker.
4) Launch the Quartus II software.
5) Open the DE2_70_Synthesizer.qpf project located in the <install path>\DE2_70_Synthesizer folder. (File menu -> Open Project)
6) Open the Programmer window. (Tools menu -> Programmer)
7) The DE2_70_Synthesizer.sof programming file should be listed.
   Check the 'Program/Configure' box and set up the JTAG programming hardware connection via the 'Hardware Setup' button.
8) Press 'Start' to start programming. The design should now be programmed and running.

User Inputs to the Design
-------------------------

KEY[0]	Reset Circuit
KEY[1]	Repeat the Demo Music
SW[0]	OFF: BRASS, ON: STRING
SW[9]	OFF: DEMO, ON: PS2 KEYBOARD
SW[1]	Channel-1 ON / OFF
SW[2]	Channel-2 ON / OFF

PS/2 Keyboard :

Q :	-#4
A :	-5
W :	-#5
S :	-6
E :	-#6
D :	-7
F :	1
T :	#1
G :	2
Y :	#2
H :	3
J :	4
I :	#4
K :	5
O :	#5
L :	6
P :	#6
: :	7
¡§ : +1


Compiling the Design
--------------------

1) Launch the Quartus II software.
2) Open the DE2_70_Synthesizer project located in the <install path>\DE2_70_Synthesizer folder. (File menu -> Open Project)
3) Start compilation. (Processing -> Start Compilation)
4) After compilation is finished, you can run the design with the generated SOF file. See 'Running the Design' above.
