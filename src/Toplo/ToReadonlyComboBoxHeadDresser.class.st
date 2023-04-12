Class {
	#name : #ToReadonlyComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'headElementFactoryHandler',
		'headPlaceholderHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> newDataElementFactory: aFactory in: anElement [

	| idx |
	anElement dataElementFactory: aFactory.
	self selectedIndex: comboBox selectedIndex in: anElement.
	(idx := comboBox selectedIndex) isZero ifFalse: [
		comboBox listElement selectIndex: idx ]
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> newPlaceholder: aPlaceholder in: anElement [

	| idx |
	anElement placeholder: aPlaceholder.
	(idx := comboBox selectedIndex) ifNil: [ ^ self ].
	idx isZero ifTrue: [ anElement noDataSelected ]
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> whenAddedToParent: anElement [

	super 	whenAddedToParent: anElement.

	headElementFactoryHandler := BlEventHandler on: ToComboBoxHeadElementFactoryChangeEvent do: [ :event | self newDataElementFactory: event factory in: anElement].
	headPlaceholderHandler := BlEventHandler on:  ToComboBoxHeadPlaceholderChangeEvent do: [ :event | self newPlaceholder: event placeholder in: anElement].
	comboBox addEventHandler: headElementFactoryHandler.
	comboBox addEventHandler: headPlaceholderHandler
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> whenRemovedFromParent: anElement [
	
	comboBox removeEventHandler: headElementFactoryHandler.
	comboBox removeEventHandler: headPlaceholderHandler.
	
	super whenRemovedFromParent: anElement


]
