Class {
	#name : #ToPopupPickOutsideEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'upCount',
		'windowManager',
		'holder',
		'checkElement',
		'plugged'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #private }
ToPopupPickOutsideEventFilter >> checkLegitimacy [
	" 
	check if the window is still present.
	If it is not present, then simply remove myself as event filter.
	"

	(self popupWindow isNil or: [ windowManager checkPickOutside not ])
		ifTrue: [ " if the window is not present or the checking flag is set to false in the windowManager.
		The window can be nil if the parent of the popup element is removed "
			holder removeEventFilter: self.
			holder := nil.
			^ false ].
	^ true
]

{ #category : #private }
ToPopupPickOutsideEventFilter >> checkUpCount [

	windowManager popupOnMouseDown ifTrue: [
		upCount isZero ifFalse: [
			upCount := upCount - 1.
			^ false ] ].
	^ true
]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> element [

	^ windowManager anchorElement
]

{ #category : #'api - accessing' }
ToPopupPickOutsideEventFilter >> eventsToHandle [

	^ { BlMouseUpEvent }
]

{ #category : #initialization }
ToPopupPickOutsideEventFilter >> initialize [ 

	super initialize.
	checkElement := true.
	plugged := true.
]

{ #category : #private }
ToPopupPickOutsideEventFilter >> isPickedOutsideEvent: anEvent [
	" return true if the event is considered as a pick outside event "

	| target |
	target := anEvent target.
	" Is it ouside the element ? "
	checkElement ifTrue: [
		(self element itemContaining: target) ifNotNil: [ :found | ^ false ] ].

	"and outside of the popup windows ? "
	self popupWindow withAllSubwindowsDo: [ :w |
		(w itemContaining: target) ifNotNil: [ ^ false ] ].

	^ true
]

{ #category : #testing }
ToPopupPickOutsideEventFilter >> isPlugged [

	^ plugged
]

{ #category : #'mouse handlers' }
ToPopupPickOutsideEventFilter >> mouseUpEvent: anEvent [
	" 
	do nothing if the original event target is the element with popup or
	if the original event target is the popup window 
	"

	"self class name trace. '>>mouseUpEvent: with upCount=' trace. upCount traceCr."
	self checkLegitimacy ifFalse: [ ^ self ].
	self isPlugged ifFalse: [ ^ self ].
	self checkUpCount ifFalse: [ ^ self ].

	self onMouseUpEvent: anEvent
]

{ #category : #'api - hooks' }
ToPopupPickOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement.
	upCount := 0
]

{ #category : #'mouse handlers' }
ToPopupPickOutsideEventFilter >> onMouseUpEvent: anEvent [
	" 
	do nothing if the original event target is the element with popup or
	if the original event target is the popup window 
	"

	| delay |
	" check a minimum delay between opening and closing - 
	useful to not close immediately context menu on mouse up"
	delay := anEvent timestamp - self popupWindow popupTimestamp.
	delay < windowManager autoCloseDelay ifTrue: [ ^ self ].

	(self isPickedOutsideEvent: anEvent) ifFalse: [ ^ self ].

	" ok, mouseUp outside the element and outside of the popup window "
	self element dispatchEvent: (ToPickOutsideEvent new
			 sourceEvent: anEvent;
			 fillFromTime: anEvent target space time;
			 yourself)
]

{ #category : #'mouse handlers' }
ToPopupPickOutsideEventFilter >> plug [ 

	plugged := true
]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> popupWindow [

	^ windowManager currentWindow

]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> shouldCheckElement: aBoolean [

	checkElement := aBoolean
]

{ #category : #'mouse handlers' }
ToPopupPickOutsideEventFilter >> unplug [ 

	plugged := false
]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> upCountRequired: anInteger [

	upCount := anInteger 
]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> windowManager: aPopupWindowManager [

	windowManager := aPopupWindowManager
]
