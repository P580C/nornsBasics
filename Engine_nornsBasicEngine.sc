// Engine_nornsBasicEngine

Engine_nornsBasicEngine : CroneEngine {
	var <synth;

	*new { arg context, doneCallback;
		^super.new(context, doneCallback);
	}

	alloc {
		synth = {
			arg out, hz=220, amp=0.5, amplag=0.02, hzlag=0.01;
			
			var amp_, hz_;

			amp_ = Lag.ar(K2A.ar(amp), amplag);
			hz_ = Lag.ar(K2A.ar(hz), hzlag);

			Out.ar(out, SinOsc.ar(hz_ + (50 * SinOsc.kr([50,51], 0, SinOsc.kr(0.12, 678, 9), 0.2, 0.8))) * amp_)
		}.play(args: [\out, context.out_b], target: context.xg);

		this.addCommand("hz", "f", { arg msg;
			synth.set(\hz, msg[1]);
		});

		this.addCommand("amp", "f", { arg msg;
			synth.set(\amp, msg[1]);
		});
	}

	// define a function that is called when the synth is shut down
	free {
		synth.free;
	}
}