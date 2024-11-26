Class {
	#name : #ToMenuBarEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - accessing' }
ToMenuBarEventHandler >> eventsToHandle [

	^ { BlMouseOverEvent }
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
