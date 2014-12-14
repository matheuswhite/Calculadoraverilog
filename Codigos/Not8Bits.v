module Not8Bits(In, Out);
	input [7:0] In;
	output [7:0] Out;
	
	not n1(Out[0], In[0]);
	not n2(Out[1], In[1]);
	not n3(Out[2], In[2]);
	not n4(Out[3], In[3]);
	not n5(Out[4], In[4]);
	not n6(Out[5], In[5]);
	not n7(Out[6], In[6]);
	not n8(Out[7], In[7]);
endmodule
