Class {
	#name : #ToStillHoveredProcessManager,
	#superclass : #ToSkinStateMouseEventProcessManager,
	#category : #'Toplo-Core-States'
}

{ #category : #'starting - stopping' }
ToStillHoveredProcessManager >> checkEvent: anEvent [

	process ifNil: [ ^ self ].
	(anEvent isKindOf: BlMouseLeaveEvent) ifFalse: [ ^ self ].
	self stopProcessFromEvent: anEvent
]

{ #category : #accessing }
ToStillHoveredProcessManager >> startDelay [

	^ self target stillHoveredStartDelay
]

{ #category : #'state generating' }
ToStillHoveredProcessManager >> startStateSkinEventClass [

	^ ToStartStillHoveredSkinEvent
]

{ #category : #'state generating' }
ToStillHoveredProcessManager >> stateSkinEventClass [

	^ ToStillHoveredSkinEvent
]

{ #category : #'state generating' }
ToStillHoveredProcessManager >> stopStateSkinEventClass [

	^ ToStopStillHoveredSkinEvent
]
