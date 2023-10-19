Class {
	#name : #ToSkinnableEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : 'Toplo-Core'
}

{ #category : #'state switching' }
ToSkinnableEventHandler >> addClickedStateEvent: anEvent [

	target addNextSkinState: (ToClickedState sourceEvent: anEvent)

]

{ #category : #'state switching' }
ToSkinnableEventHandler >> addDisabledStateEvent: anEvent [

	target skinStateEngine switchToInstallStateEvent: anEvent in: target
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> addEnabledStateEvent: anEvent [

	target skinStateEngine switchToInstallStateEvent: anEvent in: target
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> addHoveredStateEvent: anEvent [

	target addNextSkinState: (ToHoveredState sourceEvent: anEvent)
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> addLeavedStateEvent: anEvent [

	target addNextSkinState: (ToLeavedState sourceEvent: anEvent)
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> addPressedStateEvent: anEvent [

	target addNextSkinState: (ToPressedState sourceEvent: anEvent)
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> addReleasedStateEvent: anEvent [

	target addNextSkinState: (ToReleasedState sourceEvent: anEvent)
]

{ #category : #'focus events handling' }
ToSkinnableEventHandler >> blurEvent: anEvent [
]

{ #category : #'checkable event handling' }
ToSkinnableEventHandler >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	| newStateClass |
	newStateClass := anEvent current
		                 ifNil: [ ToIndeterminateState ]
		                 ifNotNil: [ :v |
			                 v
				                 ifTrue: [ ToCheckedState ]
				                 ifFalse: [ ToUncheckedState ] ].

	target addNextSkinState: (newStateClass sourceEvent: anEvent).
	target addNextSkinState: (ToClickedState sourceEvent: anEvent)
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> clickAvortedEvent: anEvent [

	(anEvent upEvent target ~= target and: [ (target findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> doubleClickEvent: anEvent [

]

{ #category : #'dnd handlers' }
ToSkinnableEventHandler >> dragEndEvent: anEvent [

	self addReleasedStateEvent: anEvent
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> dragEnterEvent: anEvent [
]

{ #category : #'dnd handlers' }
ToSkinnableEventHandler >> dragEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> dragLeaveEvent: anEvent [
]

{ #category : #'dnd handlers' }
ToSkinnableEventHandler >> dragStartEvent: anEvent [
]

{ #category : #'dnd handlers' }
ToSkinnableEventHandler >> dropEvent: anEvent [
]

{ #category : #enablement }
ToSkinnableEventHandler >> enablementChangedEvent: anEvent [

	target := anEvent currentTarget.
	target isEnabled ifTrue: [ ^ self addEnabledStateEvent: anEvent ].
	self addDisabledStateEvent: anEvent
	
]

{ #category : #'api - accessing' }
ToSkinnableEventHandler >> eventsToHandle [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToCheckableCheckedEvent. ToEnablementChangedEvent }
]

{ #category : #'api - accessing' }
ToSkinnableEventHandler >> eventsToHandleWhenDisabled [

	^ { ToEnablementChangedEvent. BlMouseEnterEvent. BlMouseLeaveEvent  }
]

{ #category : #'focus events handling' }
ToSkinnableEventHandler >> focusEvent: anEvent [
]

{ #category : #'focus events handling' }
ToSkinnableEventHandler >> focusInEvent: anEvent [
]

{ #category : #'focus events handling' }
ToSkinnableEventHandler >> focusOutEvent: anEvent [
]

{ #category : #'api - event managing' }
ToSkinnableEventHandler >> handleEvent: anEvent [

	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> isPickOutsideEventRelevantForTarget: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ false ].
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> keyDownEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> keyUpEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> middleClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> middleMouseDownEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> middleMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [ self secondaryMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseDownOutsideEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseEnterEvent: anEvent [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self addHoveredStateEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseLeaveEvent: anEvent [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self addLeavedStateEvent: anEvent


]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseMoveEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseOutEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseOverEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mousePickOutsideEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseUpEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		  secondary: [ self secondaryMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseUpOutsideEvent: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ self ].
	"MouseUpOutside for a button is managed if a MouseDown (inside) has occured before (with a consequent pressed state).
	So, do not change the state if the button is not in pressed state"
	"target currentSkinState ifNotNil: [ :s | 
		s isPressedState ifFalse: [ ^ self ] ]."
	self addReleasedStateEvent: anEvent.
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseWheelEvent: anEvent [
]

{ #category : #'api - hooks' }
ToSkinnableEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	" need to store the element for mouse outside event interpreting "
	target := anElement
]

{ #category : #'api - hooks' }
ToSkinnableEventHandler >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> otherClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> otherMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> otherMouseUpEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> primaryClickEvent: anEvent [

	target switchToNextCheckStateOnClick.
	self addClickedStateEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> primaryMouseDownEvent: anEvent [

	self addPressedStateEvent: anEvent 
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> primaryMouseUpEvent: anEvent [

	self addReleasedStateEvent: anEvent.
	self addHoveredStateEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> secondaryClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> secondaryMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> secondaryMouseUpEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> shortcutEvent: anEvent [
]

{ #category : #accessing }
ToSkinnableEventHandler >> target [

	^ target
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> textInputEvent: anEvent [
]

{ #category : #'api - event managing' }
ToSkinnableEventHandler >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandle ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].

	^ eventsToHandle anySatisfy: [ :eachEventClass |
		  anEvent isKindOf: eachEventClass ]
]
