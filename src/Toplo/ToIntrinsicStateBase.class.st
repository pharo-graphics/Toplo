Class {
	#name : #ToIntrinsicStateBase,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToIntrinsicStateBase >> dispatchSkinEvent: anEvent on: anElement fromQueue: aQueue [

	anElement spaceDo: [ :sp | anEvent fillFromTime: sp time ].
	anElement dispatchEvent: anEvent
]
