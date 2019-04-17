Class {
	#name : #TfidfTest,
	#superclass : #TestCase,
	#instVars : [
		'documents',
		'tfidf'
	],
	#category : #'TF-IDF-Tests'
}

{ #category : #running }
TfidfTest >> setUp [ 
	documents := #(
		(I am Sam)
		(Sam I am)
		(I 'don''t' like green eggs and ham)).
		
	tfidf := Tfidf new.
	tfidf countWordsInAllDocuments: documents.
]

{ #category : #running }
TfidfTest >> testCountInAllDocumentsOf [
	| words expectedCounts actualCounts |
	words := #(I am Sam 'don''t' like green eggs and ham).
	
	expectedCounts := #(3 2 2 1 1 1 1 1 1).
	actualCounts := words collect: [ :w | tfidf countInAllDocumentsOf: w ].
	
	self assert: actualCounts equals: expectedCounts
	
]

{ #category : #running }
TfidfTest >> testInverseDocumentFrequencyOf [
	| words expected actual |
	words := #(I am Sam 'don''t' like green eggs and ham).
	
	expected := #(3 2 2 1 1 1 1 1 1) collect: [ :x | (1.0 / x) ln ].
	actual := words collect: [ :w | tfidf inverseDocumentFrequencyOf: w ].
	
	self assert: actual equals: expected
	
]

{ #category : #running }
TfidfTest >> testScoreOfIn [
	| sentence words expected actual |
	sentence := #(I am green green ham).
	words := #(I am green ham).
	
	expected := { 1 * (1.0 / 3) ln . 1 * (1.0 / 2) ln . 2 * (1.0 / 1) ln . 1 * (1.0 / 1) ln }.
	actual := words collect: [ :w | tfidf scoreOf: w in: sentence ].
	
	self assert: actual equals: expected
	
]

{ #category : #running }
TfidfTest >> testTermFrequencyOfIn [
	| sentence expected actual |
	sentence := #(hello world hello hello world).
	
	expected := #(3 2).
	actual := #(hello world) collect: [ :w | tfidf termFrequencyOf: w in: sentence ].
	
	self assert: actual equals: expected
	
]
