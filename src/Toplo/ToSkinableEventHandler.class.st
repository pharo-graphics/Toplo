Class {
	#name : #ToSkinableEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'privateTarget'
	],
	#category : #'Toplo-Core'
}

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> clickAvortedEvent: anEvent [

	(anEvent upEvent target ~= privateTarget and: [ (privateTarget findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self leftClickEvent: anEvent ]
		  secondary: [ self rightClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> doubleClickEvent: anEvent [

]

{ #category : #'dnd handlers' }
ToSkinableEventHandler >> dragEndEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinableEventHandler >> dragEnterEvent: anEvent [
]

{ #category : #'dnd handlers' }
ToSkinableEventHandler >> dragEvent: anEvent [
]

{ #category : #'event handling' }
ToSkinableEventHandler >> dragLeaveEvent: anEvent [
]

{ #category : #'dnd handlers' }
ToSkinableEventHandler >> dragStartEvent: anEvent [
]

{ #category : #'dnd handlers' }
ToSkinableEventHandler >> dropEvent: anEvent [
]

{ #category : #enablement }
ToSkinableEventHandler >> enablementChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isEnabled ifTrue: [ ^ self switchToInitialState ].
	self switchToDisabledState
	
]

{ #category : #'api - accessing' }
ToSkinableEventHandler >> eventsToHandle [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToEnablementChangedEvent }
]

{ #category : #'api - accessing' }
ToSkinableEventHandler >> eventsToHandleWhenDisabled [

	^ { ToEnablementChangedEvent }
]

{ #category : #'api - accessing' }
ToSkinableEventHandler >> eventsToHandleWhenEnabled [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToEnablementChangedEvent }
]

{ #category : #'api - event managing' }
ToSkinableEventHandler >> handleEvent: anEvent [

	anEvent sendTo: self 
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> leftClickEvent: anEvent [

	self switchToClickState 
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> leftMouseDownEvent: anEvent [

	self switchToPressedState 
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> leftMouseUpEvent: anEvent [

	self switchToHoveredState 
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> middleClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> middleMouseDownEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> middleMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self leftMouseDownEvent: anEvent ]
		  secondary: [ self rightMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseDownOutsideEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseEnterEvent: anEvent [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self switchToHoveredState 
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseLeaveEvent: anEvent [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self switchToLeavedState.
	self switchToInitialState 



]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseMoveEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseOutEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseOverEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseUpEvent: anEvent [

	anEvent
		  ifPrimary: [ self leftMouseUpEvent: anEvent ]
		  secondary: [ self rightMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> mouseUpOutsideEvent: anEvent [

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
ToSkinableEventHandler >> mouseWheelEvent: anEvent [
]

{ #category : #'api - hooks' }
ToSkinableEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	privateTarget := anElement
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> otherClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> otherMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> otherMouseUpEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> rightClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> rightMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinableEventHandler >> rightMouseUpEvent: anEvent [
]

{ #category : #'state switching' }
ToSkinableEventHandler >> switchToClickState [

	" when switch back to enabled state, one have to reinstall mouseListener"
	privateTarget dispatchLookEvent: ToClickedLookEvent new.
	self switchToHoveredState
]

{ #category : #'state switching' }
ToSkinableEventHandler >> switchToDisabledState [

	privateTarget switchToSkinState: ToDisabledState new
]

{ #category : #'state switching' }
ToSkinableEventHandler >> switchToHoveredState [

	privateTarget switchToSkinState: ToHoveredState new
]

{ #category : #'state switching' }
ToSkinableEventHandler >> switchToInitialState [

	" when switch back to enabled state, one have to reinstall mouseListener"
	privateTarget switchToSkinState: ToInitialState new
]

{ #category : #'state switching' }
ToSkinableEventHandler >> switchToLeavedState [

	privateTarget switchToSkinState: ToLeavedState new
]

{ #category : #'state switching' }
ToSkinableEventHandler >> switchToPressedState [

	privateTarget switchToSkinState: ToPressedState new
]

{ #category : #'api - event managing' }
ToSkinableEventHandler >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandleWhenEnabled ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].
	anEvent currentTarget isEnabled ifTrue: [
		^ eventsToHandle anySatisfy: [ :eachEventClass |
			  anEvent isKindOf: eachEventClass ] ]
]
