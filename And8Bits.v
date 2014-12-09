module And8Bits(In, In2, Out);
	input [7:0] In;
	input [2:0] In2;
	output [7:0] Out;
	
	and a1(Out[0], In[0], In2[0], In2[1], In2[2]);
	and a2(Out[1], In[1], In2[0], In2[1], In2[2]);
	and a3(Out[2], In[2], In2[0], In2[1], In2[2]);
	and a4(Out[3], In[3], In2[0], In2[1], In2[2]);
	and a5(Out[4], In[4], In2[0], In2[1], In2[2]);
	and a6(Out[5], In[5], In2[0], In2[1], In2[2]);
	and a7(Out[6], In[6], In2[0], In2[1], In2[2]);
	and a8(Out[7], In[7], In2[0], In2[1], In2[2]);
endmodule
