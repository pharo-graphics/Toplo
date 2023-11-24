Class {
	#name : 'ToTokenPropertyIndex',
	#superclass : 'ToPropertyIndex',
	#instVars : [
		'changedAction'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'adding' }
ToTokenPropertyIndex >> addAllProperties: aCollectionOfProperties [

	(aCollectionOfProperties anySatisfy: [ :p |
		 (self hasProperty: p) not ]) ifFalse: [ ^ self ].
	super addAllProperties: aCollectionOfProperties.
	self changedAction value
]

{ #category : 'adding' }
ToTokenPropertyIndex >> addProperty: anElementProperty [

	(self hasProperty: anElementProperty) ifTrue: [ ^ self ].
	super addProperty: anElementProperty.
	self changedAction value 
]

{ #category : 'accessing' }
ToTokenPropertyIndex >> changedAction [

	^ changedAction
]

{ #category : 'accessing' }
ToTokenPropertyIndex >> changedAction: aBlockNoArg [

	changedAction := aBlockNoArg
]

{ #category : 'testing' }
ToTokenPropertyIndex >> hasProperty: anElementProperty [

	" compare property value conversion to string to get a correct result in case of BlockClosure "

	| key |
	key := anElementProperty name asSymbol.
	^ (self hasPropertyNamed: key) and: [
		  (self propertyNamed: key) value asString = anElementProperty value asString ]
]

{ #category : 'initialization' }
ToTokenPropertyIndex >> initialize [ 

	super initialize.
	changedAction := [  ]
]

{ #category : 'removing' }
ToTokenPropertyIndex >> removeAllProperties [

	index ifEmpty: [ ^ self ].
	super removeAllProperties.
	self changedAction value
]

{ #category : 'removing' }
ToTokenPropertyIndex >> removePropertyNamed: aSymbol [

	(self hasPropertyNamed: aSymbol) ifFalse: [ ^ self ].
	super removePropertyNamed: aSymbol.
	self changedAction value
]
