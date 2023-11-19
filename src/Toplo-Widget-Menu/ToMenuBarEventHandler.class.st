Class {
	#name : #ToMenuBarEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'autoOpen',
		'target'
	],
	#category : 'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - accessing' }
ToMenuBarEventHandler >> eventsToHandle [

	^ { BlMouseDownEvent. BlMouseOverEvent. BlMouseUpOutsideEvent }
]

{ #category : #initialization }
ToMenuBarEventHandler >> initialize [ 

	super initialize.
	autoOpen := false
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarEventHandler >> mouseDownEvent: anEvent [
	"switch auto=open filter "

	" mouse down on the menubar stops auto-open "
	(anEvent target = target or: [
		 target menus noneSatisfy: [ :m |
			 anEvent target hasInParentChain: m ] ]) ifTrue: [ " stop auto open on mouse over "
		autoOpen := false.
		^ self ].

	" a mouse down on an opened menu stops auto-open"
	autoOpen ifTrue: [
		target menus do: [ :m |
			((anEvent target hasInParentChain: m) and: [ m menuWindow notNil])
				ifTrue: [
					autoOpen := false.
					^ self ] ] ].

	" now auto open on mouse over  "
	autoOpen := true
]

{ #category : #'mouse handlers' }
ToMenuBarEventHandler >> mouseOverEvent: anEvent [

	autoOpen ifFalse: [ ^ self ].
	
	" auto-open action "
	target menus do: [ :m |
		(anEvent target hasInParentChain: m)
			ifTrue: [ m menuWindow ifNil: [ m popupEvent: anEvent ] ]
			ifFalse: [ m closeWindow ] ]
]

{ #category : #'mouse handlers' }
ToMenuBarEventHandler >> mouseUpOutsideEvent: anEvent [

	autoOpen ifFalse: [ ^ self ].
	anEvent originalEvent target ifNil: [ ^ self ].
	(anEvent originalEvent target hasInParentChain: target)
		ifTrue: [ ^ self ].
	anEvent consumed: true.
	autoOpen := false
]

{ #category : #'api - hooks' }
ToMenuBarEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement.
	anElement allowMousePickOutsideEvent 
]

{ #category : #'api - hooks' }
ToMenuBarEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
