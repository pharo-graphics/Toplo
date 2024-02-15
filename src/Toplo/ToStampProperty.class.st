Class {
	#name : #ToStampProperty,
	#superclass : #ToPropertyWithValue,
	#category : 'Toplo-Core-Properties'
}

{ #category : #converting }
ToStampProperty >> asStampProperty [

	^ self
]

{ #category : #operating }
ToStampProperty >> read: anObject [

	Error signal: 'A stamp can''t be read. use #value instead'
]
