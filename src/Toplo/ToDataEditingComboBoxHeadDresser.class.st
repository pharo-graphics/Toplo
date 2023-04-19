Class {
	#name : #ToDataEditingComboBoxHeadDresser,
	#superclass : #ToEditableComboBoxHeadDresser,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> newListClosedHandlerIn: anElement [

	^ BlEventHandler
		  on: ToWidgetWindowClosedEvent
		  do: [ :event | anElement textField requestFocus ]
]

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> newMouseDownHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseDownEvent
		  do: [ :evt |
			  comboBox popupOrCloseEvent: evt.
			  evt target = anElement textField ifFalse: [
				  self listElementRequestFocus ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.

	anElement textField whenSaveRequestedDo: [ :saveRequested |
		anElement whenSaveRequested: saveRequested in: comboBox ].

	anElement textField whenCancelRequestedDo: [ :cancelRequested |
		anElement whenCancelRequested: cancelRequested in: comboBox ].

	downShortcut := self newArrowDownShortcutIn: anElement.
	anElement textField infinite addShortcut: downShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> whenRemoved: anElement [
	
	anElement textField infinite removeShortcut: downShortcut.

	super whenRemoved: anElement


]
