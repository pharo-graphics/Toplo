Class {
	#name : #ToSkinnableEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'privateTarget'
	],
	#category : #'Toplo-Core'
}

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> clickAvortedEvent: anEvent [

	(anEvent upEvent target ~= privateTarget and: [ (privateTarget findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self leftClickEvent: anEvent ]
		  secondary: [ self rightClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> doubleClickEvent: anEvent [

]

{ #category : #'dnd handlers' }
ToSkinnableEventHandler >> dragEndEvent: anEvent [
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

	| target |
	target := anEvent currentTarget.
	target isEnabled ifTrue: [ ^ self switchToInitialState ].
	self switchToDisabledState
	
]

{ #category : #'api - accessing' }
ToSkinnableEventHandler >> eventsToHandle [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToEnablementChangedEvent }
]

{ #category : #'api - accessing' }
ToSkinnableEventHandler >> eventsToHandleWhenDisabled [

	^ { ToEnablementChangedEvent }
]

{ #category : #'api - accessing' }
ToSkinnableEventHandler >> eventsToHandleWhenEnabled [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToEnablementChangedEvent }
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

{ #category : #'event handling' }
ToSkinnableEventHandler >> keyDownEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> keyUpEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> leftClickEvent: anEvent [

	self switchToClickState 
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> leftMouseDownEvent: anEvent [

	self switchToPressedState 
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> leftMouseUpEvent: anEvent [

	self switchToHoveredState 
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
		  ifPrimary: [ self leftMouseDownEvent: anEvent ]
		  secondary: [ self rightMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseDownOutsideEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseEnterEvent: anEvent [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self switchToHoveredState 
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseLeaveEvent: anEvent [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self switchToLeavedState.
	self switchToInitialState 



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
ToSkinnableEventHandler >> mouseUpEvent: anEvent [

	anEvent
		  ifPrimary: [ self leftMouseUpEvent: anEvent ]
		  secondary: [ self rightMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseUpOutsideEvent: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: privateTarget ]) ifTrue: [
		^ self ].
	"MouseUpOutside for a button is managed if a MouseDown (inside) has occured before (with a consequent pressed state).
	So, do not change the state if the button is not in pressed state"
	privateTarget currentSkinState ifNotNil: [ :s | 
		s isPressedState ifFalse: [ ^ self ] ].
	self switchToInitialState
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseWheelEvent: anEvent [
]

{ #category : #'api - hooks' }
ToSkinnableEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	privateTarget := anElement
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
ToSkinnableEventHandler >> rightClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> rightMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> rightMouseUpEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinnableEventHandler >> shortcutEvent: anEvent [
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToClickState [

	" when switch back to enabled state, one have to reinstall mouseListener"
	privateTarget dispatchLookEvent: ToClickedLookEvent new.
	self switchToHoveredState
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToDisabledState [

	privateTarget switchToSkinState: ToDisabledState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToHoveredState [

	privateTarget switchToSkinState: ToHoveredState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToInitialState [

	" when switch back to enabled state, one have to reinstall mouseListener"
	privateTarget switchToSkinState: ToInitialState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToLeavedState [

	privateTarget switchToSkinState: ToLeavedState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToPressedState [

	privateTarget switchToSkinState: ToPressedState new
]

{ #category : #'api - event managing' }
ToSkinnableEventHandler >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandleWhenEnabled ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].
	anEvent currentTarget isEnabled ifTrue: [
		^ eventsToHandle anySatisfy: [ :eachEventClass |
			  anEvent isKindOf: eachEventClass ] ]
]
