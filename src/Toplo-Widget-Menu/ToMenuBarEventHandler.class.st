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
		  ToPickInsideEvent.
		  ToPickOutsideEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent }
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseOverEvent: anEvent [

	target autoOpen ifFalse: [ ^ self ].
	
	" auto-open action "
	target items do: [ :m | 
		m isMenu ifTrue: [(anEvent target hasInParentChain: m)
			ifTrue: [ m menuWindow ifNil: [ m popupEvent: anEvent ] ]
			ifFalse: [ m closeWindow ] ] ]
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

	anEvent currentTarget autoOpen: true
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> pickOutsideEvent: anEvent [

	anEvent currentTarget autoOpen: false
]
