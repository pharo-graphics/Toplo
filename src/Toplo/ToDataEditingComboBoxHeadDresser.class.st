Class {
	#name : #ToDataEditingComboBoxHeadDresser,
	#superclass : #ToEditableComboBoxHeadDresser,
	#instVars : [
		'escShortcut',
		'upShortcut'
	],
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
	upShortcut := self newArrowUpShortcutIn: anElement.
	escShortcut := self newEscapeShortcutIn: anElement.
	anElement textField infinite addShortcut: downShortcut.
	anElement textField infinite addShortcut: upShortcut.	
	anElement textField infinite addShortcut: escShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> whenRemoved: anElement [
	
	anElement textField infinite removeShortcut: downShortcut.
	anElement textField infinite removeShortcut: upShortcut.
	anElement textField infinite removeShortcut: escShortcut.
	super whenRemoved: anElement


]
