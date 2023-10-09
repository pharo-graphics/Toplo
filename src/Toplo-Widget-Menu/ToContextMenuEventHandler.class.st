Class {
	#name : #ToContextMenuEventHandler,
	#superclass : #ToMenuEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - accessing' }
ToContextMenuEventHandler >> windowClosedEvent: anEvent [

	target currentAssociateWindow items do: [ :child |
		child removeFromParent.
		child removedFromMenu: target ]
]
