Class {
	#name : #ToPopupMouseUpOutsideEventFilter,
	#superclass : #ToMouseUpOutsideEventFilter,
	#instVars : [
		'manager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'mouse handlers' }
ToPopupMouseUpOutsideEventFilter >> isMouseUpOutsideEvent: anEvent [

	| target |
	target := anEvent target.
	" if a minimum delay is not exceeded then the mouse up is 
	not considered as outside"
	"(manager isMinimumDelayExceededOnEvent: anEvent) ifFalse: [ ^ false ]."
	" first consider the element itself "
	(super isMouseUpOutsideEvent: anEvent) ifFalse: [ ^ false ].
	" then consider all windows : the main popup and its sub-windows.
	Not outside if the mouse up occurs on one of the windows"

	manager currentWindow withAllSubwindowsDo: [ :w |
		(target withAllParentsInclude: w) ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
ToPopupMouseUpOutsideEventFilter >> manager: aPopupWindowMnager [

	manager := aPopupWindowMnager
]

{ #category : #'mouse handlers' }
ToPopupMouseUpOutsideEventFilter >> mouseUpEvent: anEvent [

	manager currentWindow ifNil: [
			self stop.
			^ self ].
	super mouseUpEvent: anEvent
]
