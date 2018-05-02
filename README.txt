02-05-2018
----------

Spent ages (hours!) reading GATK documentation to try and get the read groups right for BQSR. They seem to be very internally confused and all over the shop. Here is my summary:

*Best to run on merged bam files per sample. In this case, models are per-lane-per-library-per-sample.
*Usually works with >100M bases per model. Can run before / after plots (but of what?) to assess. We don't have that amount of data here.
*Alterative: run per lane instead. 
	- SO much conflicting info here
	- have to trick it into doing this using read groups.
*Read Groups:
	- GATK documentation conflicts with SAMTOOLS specification
	- there must be a UNIQUE read group ID for each read group. So, [flowcell].[lane].[index].[library]
	- PU takes precedence over ID when present for BQSR
	- PU not used by other tools? (check this)
	- set up PU as [flowcell].[lane]. This is in line with SAMTOOLS spec (i think?) but conflicts with GATK recommendations.
*To try:
	- split dedup per RG
	- merge per lane
	- run BQSR
	- this should work if PU as above.	
