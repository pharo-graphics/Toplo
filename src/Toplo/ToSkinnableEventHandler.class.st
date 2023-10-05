Class {
	#name : #ToSkinnableEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Core'
}

{ #category : #'focus events handling' }
ToSkinnableEventHandler >> blurEvent: anEvent [
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
ToSkinnableEventHandler >> mousePickOutsideEvent: anEvent [


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
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ self ].
	"MouseUpOutside for a button is managed if a MouseDown (inside) has occured before (with a consequent pressed state).
	So, do not change the state if the button is not in pressed state"
	target currentSkinState ifNotNil: [ :s | 
		s isPressedState ifFalse: [ ^ self ] ].
	self switchToInitialState
]

{ #category : #'mouse handlers' }
ToSkinnableEventHandler >> mouseWheelEvent: anEvent [
]

{ #category : #'api - hooks' }
ToSkinnableEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
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
	target dispatchLookEvent: ToClickedLookEvent new.
	self switchToHoveredState
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToDisabledState [

	target switchToSkinState: ToDisabledState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToHoveredState [

	target switchToSkinState: ToHoveredState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToInitialState [

	" when switch back to enabled state, one have to reinstall mouseListener"
	target switchToSkinState: ToInitialState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToLeavedState [

	target switchToSkinState: ToLeavedState new
]

{ #category : #'state switching' }
ToSkinnableEventHandler >> switchToPressedState [

	target switchToSkinState: ToPressedState new
]

{ #category : #'api - event managing' }
ToSkinnableEventHandler >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandle ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].
	anEvent currentTarget isEnabled ifTrue: [
		^ eventsToHandle anySatisfy: [ :eachEventClass |
			  anEvent isKindOf: eachEventClass ] ]
]
