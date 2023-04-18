Class {
	#name : #ToDataEditingComboBoxHeadDresser,
	#superclass : #ToEditableComboBoxHeadDresser,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> whenAddedToParent: anElement [

	super whenAddedToParent: anElement.

	anElement textField whenSaveRequestedDo: [ :saveRequested |
		anElement whenSaveRequested: saveRequested in: comboBox].

	anElement textField whenCancelRequestedDo: [ :cancelRequested |
		anElement whenCancelRequested: cancelRequested in: comboBox].

	downShortcut := BlShortcutWithAction new
			 combination: BlKeyCombination arrowDown ;
			 action: [ :event | comboBox requestFocus.  comboBox popupOrCloseEvent: event ];
			 name: 'Popup';
			 yourself.
	anElement textField infinite addShortcut: downShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> whenRemovedFromParent: anElement [
	
	anElement textField infinite removeShortcut: downShortcut.

	super whenRemovedFromParent: anElement


]
