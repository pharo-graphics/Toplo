Class {
	#name : 'ToReadOnlyStyleStamp',
	#superclass : 'ToAbstractProperty',
	#instVars : [
		'value'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'accessing' }
ToReadOnlyStyleStamp class >> name: aSymbol [

	^ self new name: aSymbol asSymbol
]

{ #category : 'accessing' }
ToReadOnlyStyleStamp class >> name: aSymbol value: anObject [

	^ (self name: aSymbol)
		  value: anObject;
		  yourself
]

{ #category : 'converting' }
ToReadOnlyStyleStamp >> asStyleStamp [ 

	^ self
]

{ #category : 'operating' }
ToReadOnlyStyleStamp >> read: anObject [

	self value isClosure ifFalse: [ Error signal ].
	^ self value value: anObject
]

{ #category : 'evaluating' }
ToReadOnlyStyleStamp >> value [

	^ value
]

{ #category : 'accessing' }
ToReadOnlyStyleStamp >> value: anObject [

	value := anObject
]
