Class {
	#name : #ToPopupPickOutsideEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'popupWindowManager',
		'upCount'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> element [

	^ popupWindowManager element

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
	popupWindowManager popupOnMouseDown ifTrue: [
		upCount isZero ifTrue: [
			upCount := upCount + 1.
			^ self ] ].

	target := anEvent target.
	(target hasInParentChain: self element) ifTrue: [ ^ self ].
	(target hasInParentChain: self popupWindow) ifTrue: [ ^ self ].

	anEvent consume.
	" ok, mouseUp outside the element and outside of the popup window "
	self popupWindow ifNotNil: [ :w | w close ]
]

{ #category : #'api - hooks' }
ToPopupPickOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	upCount := 0
]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> popupWindow [

	^ popupWindowManager currentWindow

]

{ #category : #accessing }
ToPopupPickOutsideEventFilter >> popupWindowManager: anObject [

	popupWindowManager := anObject
]
