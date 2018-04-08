/*
~string_viola_vca_envelope.gui;
~string_viola_vcf_envelope.gui;
*/

~string_viola_vca_envelope = MyADSR.new;
~string_viola_vcf_envelope = MyADSR.new;

~violaEnvInit = {

	~string_viola_vca_envelope.attack = 1.5;
	~string_viola_vca_envelope.decay = 2.5;
	~string_viola_vca_envelope.sustain = 0.3;
	~string_viola_vca_envelope.release = 0.65;

	~string_viola_vcf_envelope.attack = 1.5;
	~string_viola_vcf_envelope.decay = 2.5;
	~string_viola_vcf_envelope.sustain = 0.2;
	~string_viola_vcf_envelope.release = 0.65;
};

~violaEnvInit.value;
~string_viola_vca_envelope.init;
~string_viola_vcf_envelope.init;


// part 2
~violaEnv2 = {
	~string_viola_vca_envelope.attack = 0.5;
	~string_viola_vca_envelope.decay = 2.5;
	~string_viola_vca_envelope.sustain = 0.4;
	~string_viola_vca_envelope.release = 0.5;


	~string_viola_vcf_envelope.attack = 0.5;
	~string_viola_vcf_envelope.decay = 2.5;
	~string_viola_vcf_envelope.sustain = 0.2;
	~string_viola_vcf_envelope.release = 0.5;
};


















































~string_viola_vca_envelope.attack = 0.5;
~string_viola_vca_envelope.decay = 2.5;
~string_viola_vca_envelope.sustain = 0.4;
~string_viola_vca_envelope.release = 0.5;

~string_viola_vcf_envelope.attack = 0.5;
~string_viola_vcf_envelope.decay = 2.5;
~string_viola_vcf_envelope.sustain = 0.2;
~string_viola_vcf_envelope.release = 0.5;