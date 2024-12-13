Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - orientable - orientation' }
ToMenuItemListElement >> horizontal: aBoolean [

	super horizontal: aBoolean.

]

{ #category : #initialization }
ToMenuItemListElement >> initialize [

	super initialize.
	self focusability: BlFocusability none.
	self nodeWrapping: true.
	self fitContent.
	self vertical: true.
	self uniformNodeWidth: true.
	self selectionOption masked: true.
	self configureLayout
]
