Class {
	#name : #ToWindowCloseRequest,
	#superclass : #ToWindowElementEvent,
	#instVars : [
		'applicant',
		'allowed'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowCloseRequest >> allowed [

	^ allowed ifNil: [ allowed := true ]
]

{ #category : #accessing }
ToWindowCloseRequest >> allowed: aBoolean [

	self allowed ifFalse: [ ^ self ].
	allowed := aBoolean
]

{ #category : #accessing }
ToWindowCloseRequest >> applicant [

	^ applicant
]

{ #category : #accessing }
ToWindowCloseRequest >> applicant: anElement [

	applicant := anElement
]

{ #category : #sending }
ToWindowCloseRequest >> sendTo: anObject [

	anObject windowCloseRequest: self
]
