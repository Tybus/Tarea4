`timescale 1ns/100ps
module INSTR_setup
  #(parameter Tsu = 0,
              Edge = "pos")
  
  (input data, reference,
   output reg notify);

   //Verificacion de tiempo de setup con flanco creciente en la referencia
  //----------------------------------------------------------------------
  //Algunas definiciones segun el Verilog LRM 1995
  //El data_event es el "Timestamp event", esto dispara el proceso de verificacion.
  //El reference_event es el "Timecheck event" que concluye el proceso calculando si existe una violacion
  //El limit es una constante positiva.
  //La medicion de setup se hace dentro de una ventana definida como:
  //  (inicio de la ventana) = (tiempo del "timecheck event") - limit
  //  (final de la ventana)  = (tiempo del "timecheck event")
  //La violacion se da si se cumple que:
  //  (inicio de la ventana) < (tiempo del "timestamp event") < (final de la ventana)
  //
  //EJEMPLOS DE USO:
  //Para invocar un chequeo de "setup" por 1.8 unidades de
  //tiempo del dato "data" con respecto al flanco creciente
  //de la senal "reference".
  //     INSTR_setup #(1.8,"pos") su1(data, reference, notify);
  //
  //Para invocar un chequeo de "setup" por 2.8 unidades de
  //tiempo del dato "data" con respecto al flanco decreciente
  //de la senal "reference".
  //     INSTR_setup #(2.8,"neg") su2(data, reference, notify2);
  
  realtime Tdata_ev, Tref_ev, Tlimit, Tinicio_vent, Tfin_vent, Tsudata;
  
  initial
    Tlimit = Tsu;
  
  //Registrar el tiempo del "timestamp event" --Cualquier cambio en data
  //La variable "notify" se pone a cero para iniciar el proceso de verificacion
  always @ (data)
    begin
      Tdata_ev = $realtime;
	  notify = 0;
	end
  //Registrar el tiempo del "timecheck event" --Para cualquier flanco
  //Se calcula la variable "notify" de acuerdo a si hay violacion o no
  always @ (reference)
    begin
      Tref_ev = $realtime;
	  Tinicio_vent = Tref_ev - Tlimit;
	  Tfin_vent = Tref_ev;
	  if ((Tinicio_vent < Tdata_ev) && (Tdata_ev < Tfin_vent) &&
	      ((Edge == "pos") && (reference == 1) || ((Edge == "neg") && (reference == 0))))
		begin
	    notify = 1;
      Tsudata = Tfin_vent - Tdata_ev;
	    $display("%0t - ERROR SETUP(%s) (%m) Ref: %0t Medido: %0t",$time,Edge,Tlimit,Tsudata);
		end
      else
	    notify = 0;
	end
    
endmodule
module INSTR_hold #(parameter Th = 0, parameter Tsu =0, Edge = "pos") (input data, input reference, output reg notify);
  realtime Tdata_ev, Tref_ev, Tlimit, Tinicio_vent, Tfin_vent, Thdata;

  initial
    Tlimit = Th;

  //Registrar el tiempo del "timestamp event" --Cualquier cambio en data
  //La variable "notify" se pone a cero para iniciar el proceso de verificacion
  always @ (data) begin
      Tdata_ev = $realtime;
	  notify = 0;
  end

  //Registrar el tiempo del "timecheck event" --Para cualquier flanco
  //Se calcula la variable "notify" de acuerdo a si hay violacion o no
  always @ (reference) begin
      Tref_ev = $realtime;
	  Tinicio_vent = Tdata_ev + Tsu;
	  Tfin_vent = Tdata_ev + Tlimit + Tsu;
	  if ((Tinicio_vent <= Tref_ev) && (Tref_ev < Tfin_vent) &&
        ((Edge == "pos") && (reference == 1) || ((Edge == "neg") && (reference == 0)))) begin
            notify = 1;
            Thdata = Tfin_vent - Tref_ev;
            $display("%0t - ERROR HOLD(%s) (%m) Ref: %0t Medido: %0t",$time,Edge,Tlimit,Thdata);
      end else
	    notify = 0;
  end
endmodule
