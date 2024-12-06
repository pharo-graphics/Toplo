Class {
	#name : #ToSelectableLabel,
	#superclass : #ToTextField,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #initialization }
ToSelectableLabel >> initialize [

	super initialize.
	self fitContent.
	self focusability: BlFocusability none.
	self beReadonlyWithSelection 
]

{ #category : #skin }
ToSelectableLabel >> newRawSkin [ 

	^ ToSelectableLabelSkin new
]

{ #category : #initialization }
ToSelectableLabel >> primarySelectionElementClass [

	^ ToSelectableTextFieldSelectionElement 
]
