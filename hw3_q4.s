					;				left   		right 		value
node1			DCD			0x10C, 	  0x130, 	  4
node2			DCD			0x118, 	  0x124, 	  2
node3			DCD			0,     		0,     		1
node4			DCD			0,     		0,     		3
node5			DCD			0x13C, 	  0x148, 	  6
node6			DCD			0,     		0,     		5
node7			DCD			0,     		0,     		7


					LDR			R0, =5				; a value to look for 
					LDR			R1, =0x100		; struct node *R1 = node1 (aka, the root) (loads address of root node into R1)
loop			LDR			R2, [R1, #8]	; R2 = R1->value (loads valueo of current node into R2)
					CMP			R2, R0 				; 
					BEQ			found				  ; If they're equal, then branch to found 
					CMP			R2, R0 
					BLT			right 				; If less than, branch to right (subtree)  
					CMP			R2, R0				
					BGT			left 					; If greater than, branch to left (subtree) 
left 
					LDR			R1, [R1]			; Load  to update the address of left child node into R1
					CMP			R1, #0				; Checks if R1 is null (end of tree)
					BEQ			exit 					; Exit loop if "null" 
					B 			loop 					; Otherwise, continue with left child node 
					
right 		LDR			R1, [R1, #4]	; Load to update the address of right child node into R1 
					CMP			R1, #0				; Checks if R1 is null
					BEQ			exit 					
					B				loop 

found 		ADD			R1, R1, #8		; Add the size of a node to R1 (traverse to the next node)
					B				exit					; Exits loop

exit		
					END 									
