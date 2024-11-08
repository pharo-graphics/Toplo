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

	^ { BlMouseDownOutsideEvent }
]

{ #category : #'mouse handlers' }
ToMenuBarEventHandler >> mouseDownOutsideEvent: anEvent [

	target autoOpen ifFalse: [ ^ self ].
	anEvent originalEvent target ifNil: [ ^ self ].
	(anEvent originalEvent target hasInParentChain: target) ifTrue: [
		^ self ].
	anEvent consume.
	target autoOpen: false
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
