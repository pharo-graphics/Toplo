Class {
	#name : #ToUnanimityRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core'
}

{ #category : #visiting }
ToUnanimityRequestEvent >> accept [
]

{ #category : #visiting }
ToUnanimityRequestEvent >> accept: aBoolean [

	aBoolean ifFalse: [ self deny ]

	
]

{ #category : #visiting }
ToUnanimityRequestEvent >> accepted [

	^ sourceEvent notNil
]

{ #category : #visiting }
ToUnanimityRequestEvent >> denied [

	^ self accepted not
]

{ #category : #visiting }
ToUnanimityRequestEvent >> deny [

	sourceEvent := nil.
	self consume
]

{ #category : #accessing }
ToUnanimityRequestEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToUnanimityRequestEvent >> sourceEvent: aSelectionChangedEvent [

	sourceEvent := aSelectionChangedEvent
]
