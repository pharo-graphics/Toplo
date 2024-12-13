Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuItemListElement >> initialize [

	super initialize.
	self nodeWrapping: true.
	self fitContent.
	self vertical: true.
	self uniformNodeWidth: true.
	self selectionOption masked: true
]
