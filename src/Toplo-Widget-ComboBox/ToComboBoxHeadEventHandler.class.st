Class {
	#name : #ToComboBoxHeadEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'mouse handlers' }
ToComboBoxHeadEventHandler >> primaryMouseDownEvent: anEvent [

	anEvent consumed: true.
	super primaryMouseDownEvent: anEvent.
	anEvent currentTarget popupOrCloseEvent: anEvent
]
