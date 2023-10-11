Class {
	#name : #ToPropertyIndex,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #accessing }
ToPropertyIndex >> addAllProperties: aCollectionOfProperties [

	aCollectionOfProperties do: [ :p | self addProperty: p ]
]

{ #category : #accessing }
ToPropertyIndex >> addProperty: anElementProperty [

	self index at: anElementProperty name asSymbol put: anElementProperty
]

{ #category : #accessing }
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

{ #category : #accessing }
ToPropertyIndex >> isEmpty [

	^ self index isEmpty
]

{ #category : #accessing }
ToPropertyIndex >> propertyNamed: aName [

	^ self propertyNamed: aName ifAbsent: [  ]
]

{ #category : #accessing }
ToPropertyIndex >> propertyNamed: aName ifAbsent: absentBlock [

	^ self index at: aName asSymbol ifAbsent: absentBlock
]

{ #category : #accessing }
ToPropertyIndex >> removeAllProperties [

	index removeAll
]

{ #category : #accessing }
ToPropertyIndex >> removeProperty: anElementProperty [

	self removeProperty: anElementProperty ifAbsent: [  ]
]

{ #category : #accessing }
ToPropertyIndex >> removeProperty: anElementProperty ifAbsent: anAbsentBlock [

	self index removeKey: anElementProperty name asSymbol ifAbsent: anAbsentBlock
]

{ #category : #accessing }
ToPropertyIndex >> removePropertyNamed: aSymbol [

	self
		removePropertyNamed: aSymbol
		ifAbsent: [ (ToElementPropertyNotFound name: aSymbol) signal ]
]

{ #category : #accessing }
ToPropertyIndex >> removePropertyNamed: aSymbol ifAbsent: anAbsentBlock [

	self index removeKey: aSymbol asSymbol ifAbsent: anAbsentBlock
]

{ #category : #accessing }
ToPropertyIndex >> size [ 

	^ index size
]
