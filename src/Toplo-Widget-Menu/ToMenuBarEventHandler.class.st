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
		  ToPickInsideEvent.
		  ToPickOutsideEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent }
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseOverEvent: anEvent [

	target mouseOverEvent: anEvent
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseUpEvent: anEvent [

"	anEvent target traceCr.
	(anEvent target = target or: [
		 target items anySatisfy: [ :m |
			 m isMenu not and: [ anEvent target hasInParentChain: m ] ] ]) ifTrue: [
		^ self ].
"
"	anEvent currentTarget startAutoOpen"
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

{ #category : #'event handling' }
ToMenuBarEventHandler >> pickInsideEvent: anEvent [

	anEvent currentTarget startAutoOpen
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> pickOutsideEvent: anEvent [

	anEvent currentTarget cancelAutoOpen 
]
