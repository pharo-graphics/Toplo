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
		anElement whenCancelRequested: cancelRequested in: comboBox]
]

{ #category : #'api - install/uninstall  hook' }
ToDataEditingComboBoxHeadDresser >> whenRemovedFromParent: anElement [
	
	super whenRemovedFromParent: anElement


]
