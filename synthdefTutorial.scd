
/* SynthDefs
A SynthDef can be thought of as a type of template for making sounds.  Another way of looking at a synthdef is you are creating a little synthesizer in software, or a synth patch. */

//Definition and instance

/* Once you have created a synthdef and added it to the server it is like a mold or pattern to make sound but does not make sound on its own.  You have to create synth 'instances' based on the synthdef to make sound.  The nice thing about this is you can create many different synth instances based on a single synthdef, limited only by your computer's capacity. */

//Simple example:

(
SynthDef( \square, {
	Out.ar( 0, Pulse.ar(300) );
}).add;
)

a = Synth(\square);
a.free;

//Multple Instances
a = Synth(\square);
b = Synth(\Square);
a.free;
b.free;




//SYNTAX
/*Notice the syntax.  In its simplest form it could be SynthDef(), with the parenthesis declaring the scope of the SynthDef.  In general it takes 2 arguments:
SynthDef( 'name of synthdef', 'function that describes the synthesis')
.add passes the synthdef to the server
Functions occur within curly brackets and this is where the magic happens.
The Out.ar ugen is the object that sends audio out to the soundcard and is present in most sound making synthdefs. */

//ARGUMENTS VARIABLES AND OUT
//You can greatly expand a synthdefs usefullness by using arguments and variables.  Take this example:

SynthDef(\pulse2, {
	arg freq=300, amp=0.5;
	var sqrsynth;
	sqrsynth = Pulse.ar(freq);
	Out.ar(0, sqrsynth*amp);
}).add;

/*You might notice the freq argument that is then passed on to the Pulse ugen.  Since freq has been included as an argument it can be adjusted for each instance.  To assign arguments while creating a synth instance use the following syntax: */

a = Synth(\pulse2, [\freq, 100, \amp, 0.4] );

//Supercollider is a real-time environment and you can modify synth instances while they are running using arguments.  This is the syntax:

a.set(\freq, 800);

//Variables are used within the synthdef to simplify and easily reuse data and bits of code but are not modifiable on the instance level.

//REITERATING 'LEGO' STYLE

//A common use of variables is to build a synthesis by building blocks one on top of the other like legos:

SynthDef(\pulse2, {
	arg freq=300, amp=0.5;
	var sqrsynth, noise;
	sqrsynth = Pulse.ar(freq);
	sqrsynth = LPF.ar(sqrsynth, 500);
	noise = WhiteNoise.ar(0.5);
	sqrsynth = Mix.ar([sqrsynth, noise]);
	Out.ar(0, sqrsynth*amp);
}).add;


//STORING AND LOADING ADD VERSUS LOAD
/*When using .add your synthdef is temporarliy added to the server for this session.  You can also store the synthdef in a more permenant way on your local computer in a file which is located here by using .load.  You can now create synth instances without having to resend the synthdef */



SynthDef(\pulse2, {
	arg freq=300, amp=0.5;
	var sqrsynth, noise;
	sqrsynth = Pulse.ar(freq);
	sqrsynth = LPF.ar(sqrsynth, 500);
	noise = WhiteNoise.ar(0.5);
	sqrsynth = Mix.ar([sqrsynth, noise]);
	Out.ar(0, sqrsynth*amp);
}).load;

