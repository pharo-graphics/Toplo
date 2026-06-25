Class {
	#name : #ToSelectableLabel,
	#superclass : #ToTextField,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #configuration }
ToSelectableLabel >> applyConfiguration [

	super applyConfiguration.
	self albumEditorElement hFitContent.
	self fitContent
]

{ #category : #initialization }
ToSelectableLabel >> initialize [

	super initialize.
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
