Class {
	#name : #BaselineOfTfidf,
	#superclass : #BaselineOf,
	#category : #BaselineOfTfidf
}

{ #category : #baselines }
BaselineOfTfidf >> baseline: spec [
	<baseline>
	spec for: #common do: [
		
		"Packages"
		spec 
			package: 'Tfidf';
			package: 'Tfidf-Tests' with: [ spec requires: #('Tfidf') ] ]
]
