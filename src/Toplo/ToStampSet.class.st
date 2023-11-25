Class {
	#name : 'ToStampSet',
	#superclass : 'Object',
	#instVars : [
		'changedAction',
		'set'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'adding-removing' }
ToStampSet >> add: anObject [

	self set add: anObject
]

{ #category : 'adding-removing' }
ToStampSet >> addAll: aCollection [

	self set addAll: aCollection
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

{ #category : 'adding-removing' }
ToStampSet >> remove: anObject [

	self set remove: anObject ifAbsent: [  ]
]

{ #category : 'adding-removing' }
ToStampSet >> removeAll [

	set := nil
]

{ #category : 'adding-removing' }
ToStampSet >> removeAll: aCollection [

	self set removeAll: aCollection
]

{ #category : 'accessing' }
ToStampSet >> set [

	^ set ifNil: [ set := IdentitySet new ]
]
