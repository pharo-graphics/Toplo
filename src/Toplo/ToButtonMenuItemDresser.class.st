Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'events handling' }
ToButtonMenuItemDresser >> up: anElement event: anEvent [

	super up: anElement event: anEvent.
	anElement allParentMenusDo: [ :pm | pm subMenuWindow close ]
]
