Class {
	#name : #ToContextMenuEventHandler,
	#superclass : #ToMenuEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'window handlers' }
ToContextMenuEventHandler >> contextMenuClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'mouse handlers' }
ToContextMenuEventHandler >> mouseDownOutsideEvent: anEvent [

	target contextMenuWindow ifNil: [ ^ self ].
	" must test in the original target is one of my menu items element "
	(target contextMenuWindow includes: anEvent originalEvent target)
		ifTrue: [ ^ self ].
	" no - mouse outside the context menu "
	self closeWindow
]

{ #category : #'window handlers' }
ToContextMenuEventHandler >> windowClosedEvent: anEvent [

	target contextMenuWindow items do: [ :child |
		child removeFromParent.
		child removedFromMenu: target ]
]
