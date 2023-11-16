Class {
	#name : 'ToStyleStampIndex',
	#superclass : 'ToPropertyIndex',
	#instVars : [
		'changedAction'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'adding' }
ToStyleStampIndex >> addAllProperties: aCollectionOfProperties [

	(aCollectionOfProperties anySatisfy: [ :p |
		 (self hasProperty: p) not ]) ifFalse: [ ^ self ].
	super addAllProperties: aCollectionOfProperties.
	self changedAction value
]

{ #category : 'adding' }
ToStyleStampIndex >> addProperty: anElementProperty [

	(self hasProperty: anElementProperty) ifTrue: [ ^ self ].
	super addProperty: anElementProperty.
	self changedAction value 
]

{ #category : 'accessing' }
ToStyleStampIndex >> changedAction [

	^ changedAction
]

{ #category : 'accessing' }
ToStyleStampIndex >> changedAction: aBlockNoArg [

	changedAction := aBlockNoArg
]

{ #category : 'testing' }
ToStyleStampIndex >> hasProperty: anElementProperty [

	" compare property value conversion to string to get a correct result in case of BlockClosure "

	| key |
	key := anElementProperty name asSymbol.
	^ (self hasPropertyNamed: key) and: [
		  (self propertyNamed: key) value asString = anElementProperty value asString ]
]

{ #category : 'initialization' }
ToStyleStampIndex >> initialize [ 

	super initialize.
	changedAction := [  ]
]

{ #category : 'removing' }
ToStyleStampIndex >> removeAllProperties [

	index ifEmpty: [ ^ self ].
	super removeAllProperties.
	self changedAction value
]

{ #category : 'removing' }
ToStyleStampIndex >> removePropertyNamed: aSymbol [

	super removePropertyNamed: aSymbol.
	self changedAction value

]
