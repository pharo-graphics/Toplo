Class {
	#name : #ToCheckableEventHandler,
	#superclass : #ToSkinableEventHandler,
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

	privateTarget switchToSkinState: newState.
	privateTarget dispatchLookEvent: ToClickedLookEvent new.		
	
]

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandleWhenEnabled [

	^ super eventsToHandleWhenEnabled, { ToCheckableCheckedEvent }
]

{ #category : #'state switching' }
ToCheckableEventHandler >> switchToClickState [

	privateTarget switchToNextCheckState.
	super switchToClickState
]
