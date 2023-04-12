Class {
	#name : #ToEditableComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'headPlaceholderHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newPlaceholder: aPlaceholder in: anElement [

	| idx |
	anElement placeholder: aPlaceholder.
	(idx := comboBox selectedIndex) ifNil: [ ^ self ].
	idx isZero ifTrue: [ anElement noDataSelected ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenAddedToParent: anElement [

	super 	whenAddedToParent: anElement.

	headPlaceholderHandler := BlEventHandler on: ToComboBoxHeadPlaceholderChangeEvent do: [ :event | self newPlaceholder: event placeholder in: anElement].
	comboBox addEventHandler: headPlaceholderHandler
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenRemovedFromParent: anElement [
	
	comboBox removeEventHandler: headPlaceholderHandler.
	
	super whenRemovedFromParent: anElement


]
