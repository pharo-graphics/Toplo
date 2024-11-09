Class {
	#name : #ToPopupPickOutsideEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'upCount',
		'windowManager',
		'holder'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'as yet unclassified' }
ToPopupPickOutsideEventFilter >> element [

	^ windowManager element

]

{ #category : #'api - accessing' }
ToPopupPickOutsideEventFilter >> eventsToHandle [

	^ { BlMouseUpEvent }
]

{ #category : #'mouse handlers' }
ToPopupPickOutsideEventFilter >> mouseUpEvent: anEvent [
	" 
	do nothing if the original event target is the element with popup or
	if the original event target is the popup window 
	"

	| target |
	
	"self class name trace. '>>mouseUpEvent: with upCount=' trace. upCount traceCr."
	
	self popupWindow ifNil: [ " if the window is not present 
		This can be the case if the parent of the popup element is removed "
		holder removeEventFilter: self.
		holder := nil.
		^ self ].

	windowManager popupOnMouseDown ifTrue: [
		upCount isZero ifTrue: [
			upCount := upCount + 1.
			^ self ] ].

	" It it ouside the element and outside the popup windows "
	target := anEvent target.
	(target hasInParentChain: self element) ifTrue: [ ^ self ].
	self popupWindow withAllSubwindowsDo: [ :w |
		(target hasInParentChain: w) ifTrue: [ ^ self ] ].

	anEvent consume.
	" ok, mouseUp outside the element and outside of the popup window "
	self element dispatchEvent: ToPickOutsideEvent new
]

{ #category : #'api - hooks' }
ToPopupPickOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement.
	upCount := 0
]

{ #category : #'as yet unclassified' }
ToPopupPickOutsideEventFilter >> popupWindow [

	^ windowManager currentWindow

]

{ #category : #'as yet unclassified' }
ToPopupPickOutsideEventFilter >> windowManager: aPopupWindowManager [

	windowManager := aPopupWindowManager
]