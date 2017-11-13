#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "include.h"
#include "opcode.h"




uint32_t create_machine_code(Instr i){
	uint32_t code = 0;
	// code |= 0b11;//下位2ビットは 11
	int opcode = i-> opcode;
	code |= opcode;
	//rd
	if(opcode == OP_LUI || opcode == OP_AUIPC || opcode == OP_JAL || opcode == OP_JALR || opcode == OP_LOAD || opcode == OP_ALUI || opcode == OP_ALU){
		code |= (i->rd & 0b11111) << 7;
		if(i->rd > 31)fprintf(stderr,"invalid value of rd:%d\n",i->rd);
	}
	//funct3
	if(opcode == OP_BRANCH || opcode == OP_LOAD || opcode == OP_STORE || opcode == OP_ALU || opcode == OP_ALUI){
		code |= (i->funct3 & 0b111) <<12 ;
		if(i->funct3 > 7)fprintf(stderr,"invalid value of funct3:%d\n",i->funct3);
	}
	//rs1
	if (opcode ==OP_JALR || opcode == OP_BRANCH || opcode == OP_LOAD || opcode == OP_STORE || opcode == OP_ALU || opcode == OP_ALUI){
		code |= (i->rs1 & 0b11111) << 15;
		if(i->rs1 > 31)fprintf(stderr,"invalid value of rs1:%d\n",i->rs1);
	}
	//rs2
	if (opcode == OP_BRANCH || opcode == OP_STORE || opcode == OP_ALU){
		code |= (i->rs2 & 0b11111) << 20;
		if(i->rs2 > 31)fprintf(stderr,"invalid value of rs2:%2x",i->rs2);
	}
	//imm U
	if(opcode == OP_LUI || opcode == OP_AUIPC){
		code |= i->imm<<12;
	}else if(opcode == OP_JAL){
	 // if(i->imm < 0)code |= 1<<31;
		code |= i->imm << 12;

	}else if(opcode == OP_JALR || opcode == OP_LOAD || opcode == OP_ALUI){
		code |= i->imm << 20;
	}else if (opcode == OP_BRANCH || opcode == OP_STORE)
	{
		code |= (i->imm & 0b11111)<<7;
		code |= (( unsigned int )i->imm / 1<<5 )<<25;
	}
	return code;
}

