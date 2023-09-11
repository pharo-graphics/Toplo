Class {
	#name : #ToPropertyDefinitionMap,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #initialization }
ToPropertyDefinitionMap >> initialize [ 

	super initialize.
	map := IdentityDictionary new
]

{ #category : #accessing }
ToPropertyDefinitionMap >> lookUpdaterForPropertyNamed: aName [

	^ (self propertyNamed: aName) ifNotNil: [ :p | ToLookUpdater new property: p ]
]

{ #category : #accessing }
ToPropertyDefinitionMap >> map [

	^ map
]

{ #category : #accessing }
ToPropertyDefinitionMap >> propertyNamed: aName [

	^ self map at: aName ifAbsent: [  ] 
]

{ #category : #initialization }
ToPropertyDefinitionMap >> record: aPropertyDefinition [

	self map at: aPropertyDefinition name put: aPropertyDefinition
]

{ #category : #initialization }
ToPropertyDefinitionMap >> recordAll: aCollectionOfPropertyDefinition [

	aCollectionOfPropertyDefinition do: [ :d | self record: d ]
]
