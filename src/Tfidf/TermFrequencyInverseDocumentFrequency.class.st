Class {
	#name : #TermFrequencyInverseDocumentFrequency,
	#superclass : #Object,
	#instVars : [
		'perWordDocumentCount',
		'numberOfDocuments'
	],
	#category : #Tfidf
}

{ #category : #'as yet unclassified' }
TermFrequencyInverseDocumentFrequency >> inverseDocumentFrequencyOf: aWord [
	^ self log: (self numberOfDocuments / (self numberOfDocumentsThatContainWord: aWord)).
]

{ #category : #'instance creation' }
TermFrequencyInverseDocumentFrequency >> log: aNumber [
	"Natural logarithm used o compute IDF. Can be overriden by subclasses"
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

{ #category : #'as yet unclassified' }
TermFrequencyInverseDocumentFrequency >> scoreOf: aWord in: aDocument [
	| tf idf |
	tf := self termFrequencyOf: aWord in: aDocument.
	idf := self inverseDocumentFrequencyOf: aWord.
	^ tf * idf
]

{ #category : #'as yet unclassified' }
TermFrequencyInverseDocumentFrequency >> termFrequencyOf: aWord in: aDocument [
	^ aDocument occurrencesOf: aWord
]

{ #category : #'as yet unclassified' }
TermFrequencyInverseDocumentFrequency >> trainOn: aCollectionOfDocuments [
	numberOfDocuments := aCollectionOfDocuments size.
	perWordDocumentCount := (aCollectionOfDocuments flatCollect: [ :document | document asSet ]) asBag.
]

{ #category : #'as yet unclassified' }
TermFrequencyInverseDocumentFrequency >> vectorFor: aDocument [
	^ self vocabulary collect: [ :word | self scoreOf: word in: aDocument ].
]

{ #category : #'as yet unclassified' }
TermFrequencyInverseDocumentFrequency >> vocabulary [
	^ perWordDocumentCount asSet sorted
]
