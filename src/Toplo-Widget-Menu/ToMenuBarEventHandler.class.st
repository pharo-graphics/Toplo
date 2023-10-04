Class {
	#name : #ToMenuBarEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#instVars : [
		'autoOpenDresser',
		'mouseDownHandler',
		'autoOpen'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #initialization }
ToMenuBarEventHandler >> initialize [ 

	super initialize.
	autoOpen := false
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarEventHandler >> mouseDownEvent: anEvent [
	"switch auto=open dresser "

	super mouseDownEvent: anEvent.
	" mouse down on the menubar or in a menubar child with auto open "
	(anEvent target = privateTarget or: [ autoOpenDresser notNil ]) ifTrue: [
		" stop auto open on mouse over "
		autoOpen := false.
		^ self ].

	" now auto open on mouse over  "
	autoOpen := true
]

{ #category : #'mouse handlers' }
ToMenuBarEventHandler >> mouseOverEvent: anEvent [

	super mouseOverEvent: anEvent.
	autoOpen ifFalse: [ ^ self ].
	
	" auto-open action "
	privateTarget menus do: [ :m |
		(anEvent target hasInParentChain: m)
			ifTrue: [ m popupEvent: anEvent ]
			ifFalse: [ m close ] ]
]

{ #category : #'mouse handlers' }
ToMenuBarEventHandler >> mouseUpOutsideEvent: anEvent [

	autoOpen ifFalse: [ ^ self ].
	anEvent originalEvent target ifNil: [ ^ self ].
	(anEvent originalEvent target hasInParentChain: privateTarget)
		ifTrue: [ ^ self ].
	anEvent consumed: true.
	autoOpen := false
]
