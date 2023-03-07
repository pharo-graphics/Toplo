Class {
	#name : #ToFTExampleMethodListGeneratorDataSource,
	#superclass : #ToFTExampleMethodListDataSource,
	#instVars : [
		'generator',
		'size'
	],
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #initialization }
ToFTExampleMethodListGeneratorDataSource >> elementAt: anIndex [

	^ self
		elementAt: anIndex
		ifAbsent: [ self error: 'Index not found' ]
]

{ #category : #initialization }
ToFTExampleMethodListGeneratorDataSource >> elementAt: index ifAbsent: aBlock [

	[ elements size < index ]
	whileTrue: [
		generator atEnd ifTrue: [ ^ aBlock value ].
		elements add: generator next.
		generator atEnd ifTrue: [ size := elements size ] ].
	^ elements at: index
]

{ #category : #testing }
ToFTExampleMethodListGeneratorDataSource >> hasElementAt: index [

	self elementAt: index ifAbsent: [ ^ false ].
	^ true
]

{ #category : #initialization }
ToFTExampleMethodListGeneratorDataSource >> initializeClass: aClass [

	self initialize.
	"Just a big number"
	size := 10000.
	"where we are going to place the elements"
	elements := OrderedCollection new.
	"the generator"
	generator := Generator on: [ :g |
		(aClass selectors sorted: [ :a :b | a < b ])
			do: [ :each | g yield: (ToFTExampleMethodModel method: aClass>>each) ] ]
]

{ #category : #accessing }
ToFTExampleMethodListGeneratorDataSource >> size [

	^ size
]
