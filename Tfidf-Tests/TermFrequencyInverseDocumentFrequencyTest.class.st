Class {
	#name : #TermFrequencyInverseDocumentFrequencyTest,
	#superclass : #TestCase,
	#instVars : [
		'documents',
		'tfidf'
	],
	#category : #'Tfidf-Tests'
}

{ #category : #running }
TermFrequencyInverseDocumentFrequencyTest >> setUp [ 
	documents := #(
		(I am Sam)
		(Sam I am)
		(I 'don''t' like green eggs and ham)).
		
	tfidf := TermFrequencyInverseDocumentFrequency new.
	tfidf trainOn: documents.
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testInverseDocumentFrequencyOf [
	| words expected actual |
	words := #(I am Sam 'don''t' like green eggs and ham).
	
	expected := #(3 2 2 1 1 1 1 1 1) collect: [ :x | (3.0 / x) ln ].
	actual := words collect: [ :word | tfidf inverseDocumentFrequencyOf: word ].
	
	self assert: actual equals: expected
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testNumberOfDocuments [
	self assert: tfidf numberOfDocuments equals: 3
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testNumberOfDocumentsThatContainWord [
	| words expectedCounts actualCounts |
	words := #(I am Sam 'don''t' like green eggs and ham).
	
	expectedCounts := #(3 2 2 1 1 1 1 1 1).
	actualCounts := words collect: [ :w | tfidf numberOfDocumentsThatContainWord: w ].
	
	self assert: actualCounts equals: expectedCounts
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testScoreOfIn [
	| document words expected actual |
	document := #(I am green green ham).
	words := #(I am green ham).
	
	expected := { 1 * (3.0 / 3) ln . 1 * (3.0 / 2) ln . 2 * (3.0 / 1) ln . 1 * (3.0 / 1) ln }.
	actual := words collect: [ :word | tfidf scoreOf: word in: document ].
	
	self assert: actual equals: expected
	
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testTermFrequencyOfIn [
	| document expected actual |
	document := #(hello world hello hello world).
	
	expected := #(3 2).
	actual := #(hello world) collect: [ :word | tfidf termFrequencyOf: word in: document ].
	
	self assert: actual equals: expected
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testVectorFor [
	| document tf idf expected actual |
	document := #(I am green green ham).
	
	"#(I Sam am and 'don''t' eggs green ham like)"
	
	tf := #(1 0 1 0 0 0 2 1 0).
	idf := #(3 2 2 1 1 1 1 1 1) collect: [ :x | (3.0 / x) ln ].
	
	expected := tf * idf.
	actual := tfidf vectorFor: document.
	
	self assert: actual equals: expected
	
]

{ #category : #tests }
TermFrequencyInverseDocumentFrequencyTest >> testVocabulary [
	| expected actual |
	
	expected := #(I Sam am and 'don''t' eggs green ham like).
	actual := tfidf vocabulary.
	
	self assert: actual equals: expected
]
