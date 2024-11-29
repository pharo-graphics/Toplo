Class {
	#name : #ToMenuBarEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - accessing' }
ToMenuBarEventFilter >> eventsToHandle [

	^ { BlMouseDownEvent. BlMouseUpEvent}
]

{ #category : #'mouse handlers' }
ToMenuBarEventFilter >> mouseDownEvent: anEvent [
	"switch auto=open filter 
	- mouse down on the menubar, outside menu items or, ouside the menubar is a pick outside
	- do nothing in case of a sub-menuBar "

	target parentItemContainerDo: [ :mb | ^ self ].
	(target itemContaining: anEvent target) ifNotNil: [ :found |
		found isMenu ifTrue: [
			target dispatchEvent: ToPickInsideEvent new.
			^ self ] ].

	target dispatchEvent: ToPickOutsideEvent new
]

{ #category : #'mouse handlers' }
ToMenuBarEventFilter >> mouseUpEvent: anEvent [
	"switch auto=open filter "

	" mouse up outside the menubar cancels autoOpen "

	" do nothing in case of a sub-menuBar "

	target parentItemContainerDo: [ :mb | ^ self ].

	(target itemContaining: anEvent target) ifNotNil: [ :found |
		found isMenu ifTrue: [ ^ self ] ].
	target cancelAutoOpen
]

{ #category : #accessing }
ToMenuBarEventFilter >> target [

	^ target
]

{ #category : #accessing }
ToMenuBarEventFilter >> target: anObject [

	target := anObject
]
