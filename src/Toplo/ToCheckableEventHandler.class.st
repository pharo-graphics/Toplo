Class {
	#name : #ToCheckableEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'checkable event handling' }
ToCheckableEventHandler >> checkableCheckEvent: anEvent [

	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"
	| newState |
	newState := anEvent current
		       ifNil: [ ToIndeterminateState new]
		       ifNotNil: [ :v |
			       v
				       ifTrue: [ ToCheckedState sourceEvent: anEvent ]
				       ifFalse: [ ToUncheckedState sourceEvent: anEvent ] ].

	target switchToSkinState: newState.
	target dispatchLookEvent: (ToClickedLookEvent sourceEvent: anEvent).		
	
]

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ super eventsToHandle, { ToCheckableCheckedEvent }
]

{ #category : #'state switching' }
ToCheckableEventHandler >> switchToClickStateEvent: anEvent [

	target switchToNextCheckState.
	super switchToClickStateEvent: anEvent
]
