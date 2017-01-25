.data
	String:
		.asciz "Hello World of Assembly"
	Hello:
		.asciz "Hello"
.bss 
	.lcomm Destination,100
	.lcomm DestinationByRep,100
	.lcomm DestinationByStos,100
.text
	.globl _start
	_start:
		nop
		#1 Simple copying using movsb,movsw and movsl

		movl $String,%esi
		movl $Destination,%edi
	
		movsb  #8bits
		movsw  #16bits
		movsl  #32bits

		#2 Setting/Clearing the DF (Direction Flag part of EFLAGS) flag
			#DF is set i.e, 1, then ESI & EDI decremented
			#DF is cleared i.e, 0, then ESI & EDI incremented
		
		std	 #To set the DF flag
		cld 	#To clear the DF flag
		
		#3 Using REP
	
		movl $String,%esi
		movl $DestinationByRep,%edi
		movl $30,%ecx  #set the sring length in ECX
		rep movsb
		std
		
		#4 Loading string from memory into EAX register
			#ESI automatically INC/DEC based on DF flag after every LODSx instruction	
		cld
		leal String,%esi
		lodsb  #Load a byte frmo m/m location into AL
		movb $0,%al

		dec %esi  #decrement value of esi, because now it points to 'e' but, we need esi point to H for further demo.
		lodsw  #Load a word from m/m into AX
		movw $0,%ax

		sub $2,%esi  #Make ESI point back to the original string 
		lodsl  #Load a double word frmo m/m into EAX
		
		#5 Storing Strings from EAX to memory
			#EDI automatically INC/DEC based on DF flag after every STOSx instruction
		leal DestinationByStos,%edi
		stosb #Output 'H'
		stosw #Output 'HHe' because edi is incremented .
		stosl Output 'HHeHHel'

		#6 Comparing Strings
			#CMPSx subtracts the destination string from the sorce string and sets the EFLAGS register appropriately.
			#If successfully compares, then zero flag will be set otherwise not.
		cld
		leal String,%esi
		leal Hello,%edi
		cmpsw
	
		# Exit routine

		movl $1,%eax
		movl $0,%ebx
		int $0x80 
		
