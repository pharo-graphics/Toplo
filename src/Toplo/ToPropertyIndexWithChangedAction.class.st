Class {
	#name : #ToPropertyIndexWithChangedAction,
	#superclass : #ToPropertyIndex,
	#instVars : [
		'changedAction'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #adding }
ToPropertyIndexWithChangedAction >> addAllProperties: aCollectionOfProperties [

	aCollectionOfProperties ifEmpty: [ ^ self ].
	aCollectionOfProperties do: [ :p | self index at: p name asSymbol put: p ].
	changedAction value
]

{ #category : #adding }
ToPropertyIndexWithChangedAction >> addProperty: anElementProperty [

	super addProperty: anElementProperty.
	changedAction value 
]

{ #category : #accessing }
ToPropertyIndexWithChangedAction >> changedAction [

	^ changedAction
]

{ #category : #accessing }
ToPropertyIndexWithChangedAction >> changedAction: aBlockNoArg [

	changedAction := aBlockNoArg
]

{ #category : #testing }
ToPropertyIndexWithChangedAction >> hasProperty: anElementProperty [

	" compare property value conversion to string to get a correct result in case of BlockClosure "

	| key |
	key := anElementProperty name asSymbol.
	^ (self hasPropertyNamed: key) and: [
		  (self propertyNamed: key) value asString = anElementProperty value asString ]
]

{ #category : #initialization }
ToPropertyIndexWithChangedAction >> initialize [ 

	super initialize.
	changedAction := [  ]
]

{ #category : #removing }
ToPropertyIndexWithChangedAction >> removeAllProperties [

	index ifEmpty: [ ^ self ].
	super removeAllProperties.
	changedAction value
]

{ #category : #removing }
ToPropertyIndexWithChangedAction >> removeAllPropertyFromNames: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	super removeAllPropertyFromNames: aCollectionOfSymbol.
	changedAction value
]

{ #category : #removing }
ToPropertyIndexWithChangedAction >> removePropertyNamed: aSymbol [

	self index removeKey: aSymbol ifAbsent: [ ^ self ].
	changedAction value
]
