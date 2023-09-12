Class {
	#name : #ToPropertyRegistry,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #initialization }
ToPropertyRegistry >> initialize [ 

	super initialize.
	map := IdentityDictionary new
]

{ #category : #accessing }
ToPropertyRegistry >> map [

	^ map
]

{ #category : #accessing }
ToPropertyRegistry >> newLookUpdaterFromPropertyName: aName [

	^ (self propertyNamed: aName) ifNotNil: [ :p | ToLookUpdater new property: p ]
]

{ #category : #accessing }
ToPropertyRegistry >> propertyNamed: aName [

	^ self map at: aName ifAbsent: [  ] 
]

{ #category : #initialization }
ToPropertyRegistry >> record: aPropertyDefinition [

	self map at: aPropertyDefinition name put: aPropertyDefinition
]

{ #category : #initialization }
ToPropertyRegistry >> recordAll: aCollectionOfPropertyDefinition [

	aCollectionOfPropertyDefinition do: [ :d | self record: d ]
]
