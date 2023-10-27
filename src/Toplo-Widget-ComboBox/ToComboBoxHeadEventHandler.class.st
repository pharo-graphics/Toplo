Class {
	#name : 'ToComboBoxHeadEventHandler',
	#superclass : 'ToSkinStateGenerator',
	#category : 'Toplo-Widget-ComboBox',
	#package : 'Toplo-Widget-ComboBox'
}

{ #category : 'mouse handlers' }
ToComboBoxHeadEventHandler >> primaryMouseDownEvent: anEvent [

	anEvent consumed: true.
	super primaryMouseDownEvent: anEvent.
	anEvent currentTarget popupOrCloseEvent: anEvent
]
