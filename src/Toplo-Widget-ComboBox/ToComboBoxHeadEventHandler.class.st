Class {
	#name : #ToComboBoxHeadEventHandler,
	#superclass : #ToSkinableEventHandler,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'mouse handlers' }
ToComboBoxHeadEventHandler >> leftMouseDownEvent: anEvent [

	anEvent consumed: true.
	super leftMouseDownEvent: anEvent.
	anEvent currentTarget popupOrCloseEvent: anEvent
]
