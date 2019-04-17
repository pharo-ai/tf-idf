Class {
	#name : #Tfidf,
	#superclass : #Object,
	#instVars : [
		'totalWordCounts',
		'perWordDocumentCount'
	],
	#category : #'TF-IDF'
}

{ #category : #'as yet unclassified' }
Tfidf >> countInAllDocumentsOf: aWord [
	^ totalWordCounts occurrencesOf: aWord
]

{ #category : #'as yet unclassified' }
Tfidf >> countWordsInAllDocuments: anArrayOfDocuments [
	totalWordCounts := (anArrayOfDocuments flatCollect: #yourself) asBag.
	perWordDocumentCount := ((anArrayOfDocuments collect: [ :document | document asSet asArray ]) flatCollect: #yourself) asBag.
]

{ #category : #'as yet unclassified' }
Tfidf >> inverseDocumentFrequencyOf: aWord [
	^ (self totalWordCount / (self numberOfDocumentsThatContainWord: aWord)) ln.
]

{ #category : #'as yet unclassified' }
Tfidf >> numberOfDocumentsThatContainWord: aWord [
	^ perWordDocumentCount occurrencesOf: aWord
	
]

{ #category : #'as yet unclassified' }
Tfidf >> scoreOf: aWord in: aDocument [
	| tf idf |
	tf := self termFrequencyOf: aWord in: aDocument.
	idf := self inverseDocumentFrequencyOf: aWord.
	^ tf * idf
]

{ #category : #'as yet unclassified' }
Tfidf >> termFrequencyOf: aWord in: aDocument [
	^ aDocument occurrencesOf: aWord
]

{ #category : #'as yet unclassified' }
Tfidf >> totalWordCount [
	^ totalWordCounts size
]
