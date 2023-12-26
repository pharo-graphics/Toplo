Class {
	#name : #ToListSelectFromToIndexEvent,
	#superclass : #ToListSelectionActionEvent,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

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
