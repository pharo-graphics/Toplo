Class {
	#name : 'ToPropertyIndexWithChangedAction',
	#superclass : 'ToPropertyIndex',
	#instVars : [
		'changedAction'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'adding' }
ToPropertyIndexWithChangedAction >> addAllProperties: aCollectionOfProperties [

	(aCollectionOfProperties anySatisfy: [ :p |
		 (self hasProperty: p) not ]) ifFalse: [ ^ self ].
	super addAllProperties: aCollectionOfProperties.
	self changedAction value
]

{ #category : 'adding' }
ToPropertyIndexWithChangedAction >> addProperty: anElementProperty [

	(self hasProperty: anElementProperty) ifTrue: [ ^ self ].
	super addProperty: anElementProperty.
	self changedAction value 
]

{ #category : 'accessing' }
ToPropertyIndexWithChangedAction >> changedAction [

	^ changedAction
]

{ #category : 'accessing' }
ToPropertyIndexWithChangedAction >> changedAction: aBlockNoArg [

	changedAction := aBlockNoArg
]

{ #category : 'testing' }
ToPropertyIndexWithChangedAction >> hasProperty: anElementProperty [

	" compare property value conversion to string to get a correct result in case of BlockClosure "

	| key |
	key := anElementProperty name asSymbol.
	^ (self hasPropertyNamed: key) and: [
		  (self propertyNamed: key) value asString = anElementProperty value asString ]
]

{ #category : 'initialization' }
ToPropertyIndexWithChangedAction >> initialize [ 

	super initialize.
	changedAction := [  ]
]

{ #category : 'removing' }
ToPropertyIndexWithChangedAction >> removeAllProperties [

	index ifEmpty: [ ^ self ].
	super removeAllProperties.
	self changedAction value
]

{ #category : 'adding' }
ToPropertyIndexWithChangedAction >> removeAllPropertyFromNames: aCollectionOfSymbol [

	| change |
	change := false.
	(aCollectionOfSymbol anySatisfy: [ :s | self hasPropertyNamed: s])
		ifTrue: [ change := true ].
	change ifFalse: [ ^ self ].
	super removeAllPropertyFromNames: aCollectionOfSymbol.
	self changedAction value
]

{ #category : 'removing' }
ToPropertyIndexWithChangedAction >> removePropertyNamed: aSymbol [

	(self hasPropertyNamed: aSymbol) ifFalse: [ ^ self ].
	super removePropertyNamed: aSymbol.
	self changedAction value
]
