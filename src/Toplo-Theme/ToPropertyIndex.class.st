Class {
	#name : #ToPropertyIndex,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #accessing }
ToPropertyIndex >> index [

	^ index
]

{ #category : #initialization }
ToPropertyIndex >> initialize [ 

	super initialize.
	index := IdentityDictionary new
]

{ #category : #accessing }
ToPropertyIndex >> propertyNamed: aName [

	^ self index at: aName asSymbol ifAbsent: [  ] 
]

{ #category : #initialization }
ToPropertyIndex >> record: aPropertyDefinition [

	self index at: aPropertyDefinition name put: aPropertyDefinition
]

{ #category : #initialization }
ToPropertyIndex >> recordAll: aCollectionOfPropertyDefinition [

	aCollectionOfPropertyDefinition do: [ :d | self record: d ]
]
