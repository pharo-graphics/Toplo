Class {
	#name : #ToStillPressedProcessManager,
	#superclass : #ToSkinStateMouseEventProcessManager,
	#category : #'Toplo-Core-States'
}

{ #category : #'starting - stopping' }
ToStillPressedProcessManager >> checkEvent: anEvent [

	(process notNil and: [ anEvent isKindOf: BlMouseUpEvent ]) ifTrue: [
		self stopProcessFromEvent: anEvent ]
]

{ #category : #accessing }
ToStillPressedProcessManager >> startDelay [

	^ self target stillPressedStartDelay
]

{ #category : #'state generating' }
ToStillPressedProcessManager >> startStateSkinEventClass [

	^ ToStartStillPressedSkinEvent
]

{ #category : #'state generating' }
ToStillPressedProcessManager >> stateSkinEventClass [

	^ ToStillPressedSkinEvent
]

{ #category : #'state generating' }
ToStillPressedProcessManager >> stopStateSkinEventClass [

	^ ToStopStillPressedSkinEvent
]
