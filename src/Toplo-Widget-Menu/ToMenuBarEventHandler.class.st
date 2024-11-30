Class {
	#name : #ToMenuBarEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target',
		'pickOutsideFilter',
		'root'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'event handling' }
ToMenuBarEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	pickOutsideFilter ifNotNil: [ ^ self ].
	pickOutsideFilter := ToMenuBarEventFilter new.
	pickOutsideFilter target: target.
	root := target space root.
	root addEventFilter: pickOutsideFilter
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	pickOutsideFilter ifNil: [ ^ self ].
	root removeEventFilter: pickOutsideFilter.
	pickOutsideFilter := nil.
	root := nil
]

{ #category : #'api - accessing' }
ToMenuBarEventHandler >> eventsToHandle [

	^ {
		  BlMouseOverEvent.
		  BlMouseUpEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent }
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseOverEvent: anEvent [

	target mouseOverEvent: anEvent
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseUpEvent: anEvent [

	(target itemContaining: anEvent target) ifNotNil: [ :found |
		found isMenu ifFalse: [
			target cancelAutoOpen.
			^ self ] ]
]

{ #category : #'api - hooks' }
ToMenuBarEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : #'api - hooks' }
ToMenuBarEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
