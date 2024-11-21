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

	index at: anElementProperty name asSymbol put: anElementProperty
]

{ #category : #accessing }
ToPropertyIndex >> allProperties [

	^ index associations
]

{ #category : #accessing }
ToPropertyIndex >> allPropertyNames [

	^ index keys
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
	index := IdentityDictionary new.
]

{ #category : #testing }
ToPropertyIndex >> isEmpty [

	^ index isEmpty
]

{ #category : #testing }
ToPropertyIndex >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #querying }
ToPropertyIndex >> propertyNamed: aName [

	^ self propertyNamed: aName ifAbsent: [  ]
]

{ #category : #querying }
ToPropertyIndex >> propertyNamed: aName ifAbsent: absentBlock [

	^ index at: aName asSymbol ifAbsent: absentBlock
]

{ #category : #removing }
ToPropertyIndex >> removeAllProperties [

	index removeAll
]

{ #category : #removing }
ToPropertyIndex >> removeAllPropertiesFromNames: aCollectionOfSymbol [

	aCollectionOfSymbol do: [ :s | index removeKey: s ifAbsent: [  ] ]
]

{ #category : #removing }
ToPropertyIndex >> removePropertyNamed: aSymbol [

	index removeKey: aSymbol ifAbsent: [ ^ self ]
]

{ #category : #accessing }
ToPropertyIndex >> size [ 

	^ index size
]
