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
		  BlMouseLeaveEvent.
		  BlMouseOverEvent.
		  BlMouseUpEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseLeaveEvent: anEvent [

	target itemList secondarySelecter deselectAll
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
