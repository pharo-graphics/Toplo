Class {
	#name : #ToDropdownListElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-DropdownButton'
}

{ #category : #initialization }
ToDropdownListElement >> initialize [

	super initialize.
	self primarySelectionMode selectOnMouseDown: true.
	self primarySelectionMode requestFocusOnMouseDown: false.
	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #skin }
ToDropdownListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]
