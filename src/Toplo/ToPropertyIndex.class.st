Class {
	#name : #ToPropertyIndex,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #adding }
ToPropertyIndex >> addAllProperties: aCollectionOfProperties [

	aCollectionOfProperties do: [ :p | self addProperty: p ]
]

{ #category : #adding }
ToPropertyIndex >> addProperty: anElementProperty [

	self index at: anElementProperty name asSymbol put: anElementProperty
]

{ #category : #testing }
ToPropertyIndex >> hasPropertyNamed: aName [

	^ (self propertyNamed: aName asSymbol) notNil
]

{ #category : #accessing }
ToPropertyIndex >> index [

	^ index
]

{ #category : #initialization }
ToPropertyIndex >> initialize [ 

	super initialize.
	index := IdentityDictionary new
]

{ #category : #testing }
ToPropertyIndex >> isEmpty [

	^ self index isEmpty
]

{ #category : #querying }
ToPropertyIndex >> propertyNamed: aName [

	^ self propertyNamed: aName ifAbsent: [  ]
]

{ #category : #querying }
ToPropertyIndex >> propertyNamed: aName ifAbsent: absentBlock [

	^ self index at: aName asSymbol ifAbsent: absentBlock
]

{ #category : #removing }
ToPropertyIndex >> removeAllProperties [

	index removeAll
]

{ #category : #removing }
ToPropertyIndex >> removeProperty: anElementProperty [

	self removeProperty: anElementProperty ifAbsent: [  ]
]

{ #category : #removing }
ToPropertyIndex >> removeProperty: anElementProperty ifAbsent: anAbsentBlock [

	self index removeKey: anElementProperty name asSymbol ifAbsent: anAbsentBlock
]

{ #category : #removing }
ToPropertyIndex >> removePropertyNamed: aSymbol [

	self
		removePropertyNamed: aSymbol
		ifAbsent: [ (ToElementPropertyNotFound name: aSymbol) signal ]
]

{ #category : #removing }
ToPropertyIndex >> removePropertyNamed: aSymbol ifAbsent: anAbsentBlock [

	self index removeKey: aSymbol asSymbol ifAbsent: anAbsentBlock
]

{ #category : #accessing }
ToPropertyIndex >> size [ 

	^ index size
]
