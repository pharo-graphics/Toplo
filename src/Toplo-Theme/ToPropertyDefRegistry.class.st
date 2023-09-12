Class {
	#name : #ToPropertyDefRegistry,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Toplo-Theme-Look'
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

{ #category : #accessing }
ToPropertyDefRegistry >> updaterForPropertyNamed: aName [

	^ (self propertyNamed: aName) ifNotNil: [ :p | ToLookUpdater new property: p ]
]
