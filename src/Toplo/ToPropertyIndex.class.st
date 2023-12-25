Class {
	#name : #ToPropertyIndex,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : 'Toplo-Core-Properties'
}

{ #category : #adding }
ToPropertyIndex >> addAllProperties: aCollectionOfProperties [

	aCollectionOfProperties do: [ :p | self index at: p name asSymbol put: p ]
]

{ #category : #adding }
ToPropertyIndex >> addProperty: anElementProperty [

	self index at: anElementProperty name asSymbol put: anElementProperty
]

{ #category : #accessing }
ToPropertyIndex >> allProperties [

	^ self index associations
]

{ #category : #accessing }
ToPropertyIndex >> allPropertyNames [

	^ self index keys
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

	^ self index isEmpty
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

	^ self index at: aName asSymbol ifAbsent: absentBlock
]

{ #category : #removing }
ToPropertyIndex >> removeAllProperties [

	index removeAll
]

{ #category : #removing }
ToPropertyIndex >> removeAllPropertyFromNames: aCollectionOfSymbol [

	aCollectionOfSymbol do: [ :s | self removePropertyNamed: s ]
]

{ #category : #removing }
ToPropertyIndex >> removePropertyNamed: aSymbol [

	self index removeKey: aSymbol ifAbsent: [ ^ self ]
]

{ #category : #accessing }
ToPropertyIndex >> size [ 

	^ index size
]
