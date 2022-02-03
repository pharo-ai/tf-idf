"
Term Frequency - Inverse Document Frequency (TF-IDF)
"
Class {
	#name : #AITermFrequencyInverseDocumentFrequency,
	#superclass : #Object,
	#instVars : [
		'numberOfDocuments',
		'wordAppereancesPerDocuments'
	],
	#category : #'AI-TF-IDF'
}

{ #category : #api }
AITermFrequencyInverseDocumentFrequency >> inverseDocumentFrequencyOf: aWord [

	^ self log: self numberOfDocuments / (self numberOfDocumentsThatContainWord: aWord)
]

{ #category : #hooks }
AITermFrequencyInverseDocumentFrequency >> log: aNumber [
	"Natural logarithm used to compute IDF. Can be overriden by subclasses"
	^ aNumber ln
]

{ #category : #accessing }
AITermFrequencyInverseDocumentFrequency >> numberOfDocuments [

	^ numberOfDocuments
]

{ #category : #accessing }
AITermFrequencyInverseDocumentFrequency >> numberOfDocumentsThatContainWord: aWord [

	^ wordAppereancesPerDocuments occurrencesOf: aWord
]

{ #category : #api }
AITermFrequencyInverseDocumentFrequency >> scoreOf: aWord in: aDocument [

	| tf idf |
	tf := self termFrequencyOf: aWord in: aDocument.
	idf := self inverseDocumentFrequencyOf: aWord.
	^ tf * idf
]

{ #category : #api }
AITermFrequencyInverseDocumentFrequency >> termFrequencyOf: aWord in: aDocument [

	^ aDocument occurrencesOf: aWord
]

{ #category : #api }
AITermFrequencyInverseDocumentFrequency >> trainOn: aCollectionOfDocuments [

	numberOfDocuments := aCollectionOfDocuments size.
	wordAppereancesPerDocuments := (aCollectionOfDocuments flatCollect: [ :document |
		document asSet ]) asBag
]

{ #category : #api }
AITermFrequencyInverseDocumentFrequency >> vectorFor: aDocument [

	^ self vocabulary collect: [ :word | self scoreOf: word in: aDocument ]
]

{ #category : #accessing }
AITermFrequencyInverseDocumentFrequency >> vocabulary [

	^ wordAppereancesPerDocuments asSet sorted
]
