Class {
	#name : #ToIntrinsicStateBase,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToIntrinsicStateBase >> dispatchSkinEvent: anEvent on: anElement fromQueue: aQueue [

	anEvent fillFromTime: anElement space time.
	anElement dispatchEvent: anEvent
]
