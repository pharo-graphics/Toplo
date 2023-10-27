Class {
	#name : 'ToContextMenuEventHandler',
	#superclass : 'ToMenuEventHandler',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'window handlers' }
ToContextMenuEventHandler >> contextMenuClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : 'window handlers' }
ToContextMenuEventHandler >> windowClosedEvent: anEvent [

	target currentContextMenu items do: [ :child |
		child removeFromParent.
		child removedFromMenu: target ]
]
