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

	| done |
	aCollectionOfProperties ifEmpty: [ ^ self ].
	done := false.
	aCollectionOfProperties do: [ :p |
		(self hasProperty: p) ifFalse: [
			done := true.
			index at: p name asSymbol put: p ] ].
	done ifTrue: [ changedAction cull: self ]
]

{ #category : #adding }
ToPropertyIndexWithChangedAction >> addProperty: anElementProperty [

	(self hasProperty: anElementProperty) ifTrue: [ ^ false ].
	super addProperty: anElementProperty.
	changedAction cull: self.
	^ true
]

{ #category : #accessing }
ToPropertyIndexWithChangedAction >> changedAction [

	^ changedAction
]

{ #category : #accessing }
ToPropertyIndexWithChangedAction >> changedAction: aBlockOneArgOpt [

	changedAction := aBlockOneArgOpt
]

{ #category : #testing }
ToPropertyIndexWithChangedAction >> hasProperty: anElementProperty [
	" compare property value conversion to string to get a correct result in case of BlockClosure "

	| key prop |
	key := anElementProperty name asSymbol.
	prop := self propertyNamed: key ifAbsent: [  ].
	^ prop notNil and: [
		  prop value isBlock
			  ifTrue: [ prop value asString = anElementProperty value asString ]
			  ifFalse: [ prop value = anElementProperty value ] ]
]

{ #category : #initialization }
ToPropertyIndexWithChangedAction >> initialize [ 

	super initialize.
	changedAction := [ :myself | ]
]

{ #category : #removing }
ToPropertyIndexWithChangedAction >> removeAllProperties [

	self isEmpty ifTrue: [ ^ self ].
	super removeAllProperties.
	changedAction cull: self
]

{ #category : #removing }
ToPropertyIndexWithChangedAction >> removeAllPropertiesFromNames: aCollectionOfSymbol [

	| done |
	aCollectionOfSymbol ifEmpty: [ ^ self ].
	done := false.
	aCollectionOfSymbol do: [ :symb |
		index at: symb asSymbol ifPresent: [ :prop |
			done := true.
			index removeKey: symb ] ].
	done ifTrue: [ changedAction cull: self ]
]

{ #category : #removing }
ToPropertyIndexWithChangedAction >> removePropertyNamed: aSymbol [

	index removeKey: aSymbol ifAbsent: [ ^ self ].
	changedAction cull: self
]
