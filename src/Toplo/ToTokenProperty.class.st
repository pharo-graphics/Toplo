"
terminology : https://design-tokens.github.io/community-group/format/#design-token

"
Class {
	#name : 'ToTokenProperty',
	#superclass : 'ToAbstractProperty',
	#instVars : [
		'value'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'accessing' }
ToTokenProperty class >> name: aSymbol [

	^ self new name: aSymbol asSymbol
]

{ #category : 'accessing' }
ToTokenProperty class >> name: aSymbol value: anObject [

	^ (self name: aSymbol)
		  value: anObject;
		  yourself
]

{ #category : 'converting' }
ToTokenProperty >> asTokenProperty [ 

	^ self
]

{ #category : 'operating' }
ToTokenProperty >> read: anObject [

	self value isClosure ifFalse: [ Error signal ].
	^ self value value: anObject
]

{ #category : 'evaluating' }
ToTokenProperty >> value [

	^ value
]

{ #category : 'accessing' }
ToTokenProperty >> value: anObject [

	value := anObject
]
