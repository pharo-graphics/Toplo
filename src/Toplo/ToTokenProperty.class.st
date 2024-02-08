"
terminology : https://design-tokens.github.io/community-group/format/#design-token

"
Class {
	#name : #ToTokenProperty,
	#superclass : #ToPropertyWithValue,
	#category : #'Toplo-Core-Properties'
}

{ #category : #converting }
ToTokenProperty >> asTokenProperty [ 

	^ self
]

{ #category : #operating }
ToTokenProperty >> read: anObject [

	self value isClosure ifFalse: [ Error signal ].
	^ self value value: anObject
]
