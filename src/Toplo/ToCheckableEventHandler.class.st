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
				       ifTrue: [ ToCheckedState new ]
				       ifFalse: [ ToUncheckedState new ] ].

	target switchToSkinState: newState.
	target dispatchLookEvent: ToClickedLookEvent new.		
	
]

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ super eventsToHandle, { ToCheckableCheckedEvent }
]

{ #category : #'state switching' }
ToCheckableEventHandler >> switchToClickState [

	target switchToNextCheckState.
	super switchToClickState
]