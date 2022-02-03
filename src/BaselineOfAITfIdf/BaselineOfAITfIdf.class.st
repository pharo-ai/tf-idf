"
Baseline of the TF-IDF
"
Class {
	#name : #BaselineOfAITfIdf,
	#superclass : #BaselineOf,
	#category : #BaselineOfAITfIdf
}

{ #category : #baselines }
BaselineOfAITfIdf >> baseline: spec [
	<baseline>
	spec for: #common do: [
		
		"Packages"
		spec 
			package: 'AI-TF-IDF';
			package: 'AI-TF-IDF-Tests' with: [ spec requires: #('AI-TF-IDF') ] ]
]
