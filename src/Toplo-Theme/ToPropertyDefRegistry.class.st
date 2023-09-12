Class {
	#name : #ToPropertyDefRegistry,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #initialization }
ToPropertyDefRegistry >> initialize [ 

	super initialize.
	map := IdentityDictionary new
]

{ #category : #accessing }
ToPropertyDefRegistry >> map [

	^ map
]

{ #category : #accessing }
ToPropertyDefRegistry >> newPropertyUpdaterFromName: aName [

	^ (self propertyNamed: aName) ifNotNil: [ :p | ToLookUpdater new property: p ]
]

{ #category : #accessing }
ToPropertyDefRegistry >> propertyNamed: aName [

	^ self map at: aName ifAbsent: [  ] 
]

{ #category : #initialization }
ToPropertyDefRegistry >> record: aPropertyDefinition [

	self map at: aPropertyDefinition name put: aPropertyDefinition
]

{ #category : #initialization }
ToPropertyDefRegistry >> recordAll: aCollectionOfPropertyDefinition [

	aCollectionOfPropertyDefinition do: [ :d | self record: d ]
]
