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
	If it is not present, the simply remove myself as event filter.
	"

	self popupWindow ifNil: [ " if the window is not present 
		This can be the case if the parent of the popup element is removed "
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

	^ windowManager element

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

	| target delay |
	"self class name trace. '>>mouseUpEvent: with upCount=' trace. upCount traceCr."
	self checkLegitimacy ifFalse: [ ^ self ].
	self isPlugged ifFalse: [ ^ self ].
	self checkUpCount ifFalse: [ ^ self ].

	" check a minimum delay between opening and closing - 
	useful to not close immediately context menu on mouse up"
	delay := anEvent timestamp - self popupWindow popupTimestamp.
	delay < windowManager autoCloseDelay ifTrue: [ ^ self ].

	" Is it ouside the element ? "
	target := anEvent target.
	checkElement ifTrue: [
		(self element itemContaining: target) ifNotNil: [ :found | ^ self ] ].
	
	"and outside of the popup windows ? "
	self popupWindow withAllSubwindowsDo: [ :w |
		(w itemContaining: target) ifNotNil: [ ^ self ] ].

	" ok, mouseUp outside the element and outside of the popup window "
	anEvent consume.
	self element dispatchEvent: ToPickOutsideEvent new
]

{ #category : #'api - hooks' }
ToPopupPickOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement.
	upCount := 0
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
