/* David Martinez Garcia
* B34019
* Escuela de Ingenieria Electrica
* Universidad de Costa Rica
* Circuitos Digitales II
*/
`timescale 1ns/100ps
module CD74HCT191(AD,DnU,nLOAD,nCTEN,CLK,MM,QAD,nRCO);
	input [3:0] AD;
	output reg [3:0] QAD;
	input DnU,nLOAD,nCTEN,CLK;
	output reg MM,nRCO;
  always @(posedge CLK) begin
    if(~(nLOAD & nCTEN)) begin
      if(nLOAD & ~nCTEN) begin
        if(DnU) begin
          QAD = QAD - 1;
          if(QAD == 0)
            MM = 1;
          else
            MM = 0;
        end
        else if(~DnU) begin
          QAD = QAD +1;
          if(QAD == 15)
            MM = 1;
          else
            MM = 0;
        end
      end
    end
  end
  always @(AD or DnU or nLOAD or nCTEN or CLK) begin
    if(~(nLOAD & nCTEN)) begin
      if(~nLOAD)
        QAD = AD;
      else if (MM & ~CLK)
        nRCO = 0;
      else
        nRCO = 1;
    end
  end

  specify
    specparam tpdL_Q =39; // nLOAD -> QAD
    specparam tpdAD_Q =35; // AD -> QAD
    specparam tpdCLK_Q = 34; // CLK ->QAD
    specparam tpdCLK_RCO = 25; // CLK -> nRCO
    specparam tpdCLK_MM = 42; //CLK -> MM
    specparam tpdDnU_RCO = 30; //DnU ->nRCO
    specparam tpdDnU_MM = 33; // DnU -> MM
    specparam tpdCTEN_RCO = 25; //nCTEN ->RCO
    
    (nLOAD *> QAD) = tpdL_Q;
    (AD *> QAD) = tpdAD_Q;
    (CLK *> QAD) = tpdCLK_Q;
    (CLK *> nRCO) = tpdCLK_RCO;
    (CLK *> MM) = tpdCLK_MM;
    (DnU *> nRCO) = tpdDnU_RCO;
    (DnU *> MM) = tpdDnU_MM;
    (nCTEN *> nRCO) = tpdCTEN_RCO;
  endspecify
endmodule

		
