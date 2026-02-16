Class {
	#name : #ToElementPropertyIndex,
	#superclass : #ToPropertyIndex,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToElementPropertyIndex class >> on: anElement [

	^ self new element: anElement
]

{ #category : #adding }
ToElementPropertyIndex >> addAllProperties: aCollectionOfProperties [

	| done |
	aCollectionOfProperties ifEmpty: [ ^ self ].
	done := false.
	aCollectionOfProperties do: [ :p |
		(self hasProperty: p) ifFalse: [
			done := true.
			index at: p name asSymbol put: p ] ].
	done ifTrue: [ self notifyIndexChanged ]
]

{ #category : #adding }
ToElementPropertyIndex >> addEventHandler: anEventHandler [

	element addEventHandler: anEventHandler
]

{ #category : #adding }
ToElementPropertyIndex >> addProperty: anElementProperty [

	(self hasProperty: anElementProperty) ifTrue: [ ^ false ].
	super addProperty: anElementProperty.
	self notifyIndexChanged.
	^ true
]

{ #category : #accessing }
ToElementPropertyIndex >> element: anElement [

	element := anElement
]

{ #category : #testing }
ToElementPropertyIndex >> hasProperty: anElementProperty [
	" compare property value conversion to string to get a correct result in case of BlockClosure "

	| key prop |
	key := anElementProperty name asSymbol.
	prop := self propertyNamed: key ifAbsent: [  ].
	^ prop notNil and: [
		  prop value isBlock
			  ifTrue: [ prop value asString = anElementProperty value asString ]
			  ifFalse: [ prop value = anElementProperty value ] ]
]

{ #category : #'change notification' }
ToElementPropertyIndex >> notifyIndexChanged [

	element dispatchEvent: ToPropertyIndexChangedEvent new
]

{ #category : #removing }
ToElementPropertyIndex >> removeAllProperties [

	self isEmpty ifTrue: [ ^ self ].
	super removeAllProperties.
	self notifyIndexChanged
]

{ #category : #removing }
ToElementPropertyIndex >> removeAllPropertiesFromNames: aCollectionOfSymbol [

	| done |
	aCollectionOfSymbol ifEmpty: [ ^ self ].
	done := false.
	aCollectionOfSymbol do: [ :symb |
		index at: symb asSymbol ifPresent: [ :prop |
			done := true.
			index removeKey: symb ] ].
	done ifTrue: [ self notifyIndexChanged ]
]

{ #category : #removing }
ToElementPropertyIndex >> removePropertyNamed: aSymbol [

	index removeKey: aSymbol ifAbsent: [ ^ self ].
	self notifyIndexChanged
]

{ #category : #adding }
ToElementPropertyIndex >> updateProperty: anElementProperty [

	(self hasProperty: anElementProperty) ifFalse: [
		^ self addProperty: anElementProperty ].
	index at: anElementProperty name asSymbol put: anElementProperty.
	self notifyIndexChanged.
	^ true
]
