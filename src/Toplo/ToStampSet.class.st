Class {
	#name : 'ToStampSet',
	#superclass : 'Object',
	#instVars : [
		'changedAction',
		'set'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'adding-removing' }
ToStampSet >> add: anObject [

	(self includes: anObject) ifTrue: [ ^ self ].
	self set add: anObject.
	self onChanged 
]

{ #category : 'adding-removing' }
ToStampSet >> addAll: aCollection [

	(aCollection anySatisfy: [ :p |
		 (self includes: p) not ]) ifFalse: [ ^ self ].
	self set addAll: aCollection.
	self onChanged 
]

{ #category : 'accessing' }
ToStampSet >> all [

	^ self set asArray
]

{ #category : 'accessing' }
ToStampSet >> changedAction [

	^ changedAction
]

{ #category : 'accessing' }
ToStampSet >> changedAction: aBlockNoArg [

	changedAction := aBlockNoArg
]

{ #category : 'testing' }
ToStampSet >> includes: anObject [

	^ self set includes: anObject
]

{ #category : 'testing' }
ToStampSet >> includesAll: aCollection [

	^ self set includesAll: aCollection
]

{ #category : 'initialization' }
ToStampSet >> initialize [ 

	super initialize.
	changedAction := [  ]
]

{ #category : 'testing' }
ToStampSet >> isEmpty [

	^ self set isEmpty
]

{ #category : 'hook - updating' }
ToStampSet >> onChanged [

	self changedAction value
]

{ #category : 'adding-removing' }
ToStampSet >> remove: anObject [

	self set remove: anObject ifAbsent: [ ^ self ].
	self onChanged 
]

{ #category : 'adding-removing' }
ToStampSet >> removeAll [

	self isEmpty ifTrue: [ ^self ].
	set := nil.
	self onChanged 
]

{ #category : 'adding-removing' }
ToStampSet >> removeAll: aCollection [

	(aCollection anySatisfy: [ :p | self includes: p ]) ifFalse: [
		^ self ].
	self set removeAll: aCollection.
	self onChanged 
]

{ #category : 'accessing' }
ToStampSet >> set [

	^ set ifNil: [ set := IdentitySet new ]
]
