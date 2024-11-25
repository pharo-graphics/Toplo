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

	^ { BlMouseDownEvent.  }
]

{ #category : #'mouse handlers' }
ToMenuBarEventFilter >> mouseDownEvent: anEvent [
	"switch auto=open filter "

	" mouse down on the menubar stops auto-open "
	(anEvent target = target or: [
		 target items noneSatisfy: [ :m |
			 anEvent target hasInParentChain: m ] ]) ifTrue: [ " stop auto open on mouse over "
		target autoOpen: false.
		^ self ].

	" a mouse down on an opened menu stops auto-open"
	target autoOpen ifTrue: [
		target items do: [ :m |
			((anEvent target hasInParentChain: m) and: [ m menuWindow notNil ])
				ifTrue: [
					target autoOpen: false.
					^ self ] ] ].

	" now auto open on mouse over  "
	target autoOpen: true
]

{ #category : #'api - hooks' }
ToMenuBarEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : #'api - hooks' }
ToMenuBarEventFilter >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
