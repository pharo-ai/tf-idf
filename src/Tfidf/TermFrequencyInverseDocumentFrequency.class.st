Class {
	#name : #TermFrequencyInverseDocumentFrequency,
	#superclass : #Object,
	#instVars : [
		'perWordDocumentCount',
		'numberOfDocuments'
	],
	#category : #Tfidf
}

{ #category : #internal }
TermFrequencyInverseDocumentFrequency >> inverseDocumentFrequencyOf: aWord [
	^ self log: (self numberOfDocuments / (self numberOfDocumentsThatContainWord: aWord)).
]

{ #category : #hooks }
TermFrequencyInverseDocumentFrequency >> log: aNumber [
	"Natural logarithm used to compute IDF. Can be overriden by subclasses"
	^ aNumber ln
]

{ #category : #accessing }
TermFrequencyInverseDocumentFrequency >> numberOfDocuments [
	^ numberOfDocuments 
]

{ #category : #accessing }
TermFrequencyInverseDocumentFrequency >> numberOfDocumentsThatContainWord: aWord [
	^ perWordDocumentCount occurrencesOf: aWord
	
]

{ #category : #internal }
TermFrequencyInverseDocumentFrequency >> scoreOf: aWord in: aDocument [
	| tf idf |
	tf := self termFrequencyOf: aWord in: aDocument.
	idf := self inverseDocumentFrequencyOf: aWord.
	^ tf * idf
]

{ #category : #internal }
TermFrequencyInverseDocumentFrequency >> termFrequencyOf: aWord in: aDocument [
	^ aDocument occurrencesOf: aWord
]

{ #category : #internal }
TermFrequencyInverseDocumentFrequency >> trainOn: aCollectionOfDocuments [
	numberOfDocuments := aCollectionOfDocuments size.
	perWordDocumentCount := (aCollectionOfDocuments flatCollect: [ :document | document asSet ]) asBag.
]

{ #category : #internal }
TermFrequencyInverseDocumentFrequency >> vectorFor: aDocument [
	^ self vocabulary collect: [ :word | self scoreOf: word in: aDocument ].
]

{ #category : #accessing }
TermFrequencyInverseDocumentFrequency >> vocabulary [
	^ perWordDocumentCount asSet sorted
]
