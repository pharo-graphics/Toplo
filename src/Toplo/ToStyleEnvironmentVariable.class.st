"
A base for environment variables (values that point to values in the environment).
"
Class {
	#name : #ToStyleEnvironmentVariable,
	#superclass : #ToStyleAbstractVariable,
	#instVars : [
		'name'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #documentation }
ToStyleEnvironmentVariable class >> addDocumentExample: aBuilder [

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Example' ] withLevel: 2.
	aBuilder newLine.
	aBuilder monospace: self documentExampleCode
]

{ #category : #documentation }
ToStyleEnvironmentVariable class >> addDocumentValidValues: aBuilder [	

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Valid values' ] withLevel: 2.
	aBuilder newLine.
	aBuilder unorderedListDuring: [  
		(self documentValidValues sorted) do: [ :each |
			aBuilder item: [
				aBuilder monospace: '#', each asString ] ] ]	
]

{ #category : #documentation }
ToStyleEnvironmentVariable class >> documentExampleCode [

	^ '(none)'
]

{ #category : #documentation }
ToStyleEnvironmentVariable class >> documentValidValues [
	
	^ #()
]

{ #category : #'ston-core' }
ToStyleEnvironmentVariable class >> stonName [

	^ 'Environment'
]

{ #category : #'instance creation' }
ToStyleEnvironmentVariable >> fromSton: stonReader [

	self name: stonReader parseContainedValue
]

{ #category : #testing }
ToStyleEnvironmentVariable >> isEnvironmentVariable [

	^ true
]

{ #category : #accessing }
ToStyleEnvironmentVariable >> name [
	^ name
]

{ #category : #accessing }
ToStyleEnvironmentVariable >> name: anObject [
	name := anObject
]
