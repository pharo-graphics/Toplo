Class {
	#name : #ToDropdownListElement,
	#superclass : #ToListElement,
	#instVars : [
		'dropdownButton'
	],
	#category : #'Toplo-Widget-DropdownButton'
}

{ #category : #accessing }
ToDropdownListElement >> dropdownButton [

	^ dropdownButton
]

{ #category : #accessing }
ToDropdownListElement >> dropdownButton: aDropDown [

	dropdownButton := aDropDown
]

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
