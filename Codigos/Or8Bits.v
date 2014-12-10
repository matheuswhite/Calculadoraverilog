module Or8Bits(In, In2, Out);
	input [7:0] In;
	input [7:0] In2;
	output [7:0] Out;
	
	or o1(Out[0], In[0], In2[0]);
	or o2(Out[1], In[1], In2[1]);
	or o3(Out[2], In[2], In2[2]);
	or o4(Out[3], In[3], In2[3]);
	or o5(Out[4], In[4], In2[4]);
	or o6(Out[5], In[5], In2[5]);
	or o7(Out[6], In[6], In2[6]);
	or o8(Out[7], In[7], In2[7]);
endmodule
