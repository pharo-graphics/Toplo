Class {
	#name : #ToListSelectFromToIndexEvent,
	#superclass : #ToListSelectionActionEventDep,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListSelectFromToIndexEvent class >> isDeprecated [

	^ true
]

{ #category : #accessing }
ToListSelectFromToIndexEvent >> interval [

	^ interval
]

{ #category : #accessing }
ToListSelectFromToIndexEvent >> interval: anInterval [

	interval := anInterval
]

{ #category : #printing }
ToListSelectFromToIndexEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' interval: '.
	self interval printOn: aStream
]

{ #category : #sending }
ToListSelectFromToIndexEvent >> sendTo: anObject [

	anObject listSelectFromToIndexEvent: self
]
