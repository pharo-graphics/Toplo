Class {
	#name : #ToSingleSelectTextInputElement,
	#superclass : #ToSelectTextInputElement,
	#category : #'Toplo-Widget-Select-textInput'
}

{ #category : #private }
ToSingleSelectTextInputElement >> checkPlaceholderText [
	" the selectedDataTextField contains the selected data string 
	which is hidden when the inputTextField is not empty "

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
