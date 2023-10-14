Class {
	#name : 'ToComboBoxHeadEventHandler',
	#superclass : 'ToSkinnableEventHandler',
	#category : 'Toplo-Widget-ComboBox',
	#package : 'Toplo-Widget-ComboBox'
}

{ #category : 'mouse handlers' }
ToComboBoxHeadEventHandler >> leftMouseDownEvent: anEvent [

	anEvent consumed: true.
	super leftMouseDownEvent: anEvent.
	anEvent currentTarget popupOrCloseEvent: anEvent
]
