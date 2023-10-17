Class {
	#name : 'ToCheckableEventHandler',
	#superclass : 'ToSkinnableEventHandler',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'checkable event handling' }
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
	target switchToSkinState: (ToClickedState sourceEvent: anEvent)
	
]

{ #category : 'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ super eventsToHandle, { ToCheckableCheckedEvent }
]

{ #category : 'state switching' }
ToCheckableEventHandler >> switchToClickedStateEvent: anEvent [

	target switchToNextCheckState.
	super switchToClickedStateEvent: anEvent
]
