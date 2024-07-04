Class {
	#name : #ToSingleSelectTextInputElement,
	#superclass : #ToSelectTextInputElement,
	#category : #'Toplo-Widget-Select-textInput'
}

{ #category : #private }
ToSingleSelectTextInputElement >> checkPlaceholderText [
	" In case of single selection, the selectedDataTextField can contain 
	either the placeholder text or the selected data string"

	self inputTextField text
		ifEmpty: [
		self selectedDataTextField visibility: BlVisibility visible.
		self selectedDataTextField text foreground: Color lightGray ]
		ifNotEmpty: [
		self selectedDataTextField visibility: BlVisibility hidden ]
]

{ #category : #initialization }
ToSingleSelectTextInputElement >> configureTextField: aTextField [

	aTextField withoutLineWrapping.
	aTextField hMatchParent
]
