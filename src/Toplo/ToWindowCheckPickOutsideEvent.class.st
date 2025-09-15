Class {
	#name : #ToWindowCheckPickOutsideEvent,
	#superclass : #BlEvent,
	#instVars : [
		'allowed'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowCheckPickOutsideEvent >> allowed [

	^ allowed
]

{ #category : #accessing }
ToWindowCheckPickOutsideEvent >> allowed: aBoolean [

	allowed := aBoolean
]

{ #category : #sending }
ToWindowCheckPickOutsideEvent >> sendTo: anObject [

	anObject windowCheckPickOutsideEvent: self
]
