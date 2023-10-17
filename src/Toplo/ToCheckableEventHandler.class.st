Class {
	#name : 'ToCheckableEventHandler',
	#superclass : 'ToSkinnableEventHandler',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'state switching' }
ToCheckableEventHandler >> addClickedStateEvent: anEvent [

	target switchToNextCheckState.
	super addClickedStateEvent: anEvent
]

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

	target addNextSkinState: newState.
	target addNextSkinState: (ToClickedState sourceEvent: anEvent)
	
]

{ #category : 'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ super eventsToHandle, { ToCheckableCheckedEvent }
]
