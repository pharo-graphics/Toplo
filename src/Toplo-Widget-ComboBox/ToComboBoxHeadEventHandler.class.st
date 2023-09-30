Class {
	#name : #ToComboBoxHeadEventHandler,
	#superclass : #ToSkinableEventHandler,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'mouse handlers' }
ToComboBoxHeadEventHandler >> leftMouseDownEvent: anEvent [

	anEvent consumed: true.
	super leftMouseDownEvent: anEvent.
	anEvent currentTarget comboBox popupOrCloseEvent: anEvent
]

{ #category : #'mouse handlers' }
ToComboBoxHeadEventHandler >> leftMouseUpEvent: anEvent [

	super leftMouseUpEvent: anEvent
]
