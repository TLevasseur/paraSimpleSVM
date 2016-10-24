# paraSimpleSVM
Parrallel block-wise implementation of SimpleSVM in Matlab.

Simple SVM is an active constraints algorithm solving a constrained Quadratic Programing problem.

Usecase example provided in example.m

## Octave user
Octave requires two
<pre>
warning('off','Octave:possible-matlab-short-circuit-operator');
more off;
</pre>
Change 'parfor' keyword to 'for' to disable parrallel computing in paramonqp.m file.
<pre>%parfor i=1:2
for i=1:2
</pre>
