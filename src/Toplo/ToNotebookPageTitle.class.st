Class {
	#name : #ToNotebookPageTitle,
	#superclass : #ToGeneralButton,
	#instVars : [
		'#isSelected => ObservableSlot',
		'#labelElement'
	],
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #initialization }
ToNotebookPageTitle >> initialize [

	super initialize.
	
	isSelected := false.
	labelElement := ToLabel new.
	labelElement matchParent.
	self addChild: labelElement.
]

{ #category : #accessing }
ToNotebookPageTitle >> isSelected [

	^ isSelected
]

{ #category : #accessing }
ToNotebookPageTitle >> isSelected: aBoolean [

	isSelected := aBoolean
]

{ #category : #accessing }
ToNotebookPageTitle >> labelElement [

	^ labelElement
]

{ #category : #accessing }
ToNotebookPageTitle >> title: aString [ 
	
	labelElement text: aString asRopedText
]

{ #category : #enumerating }
ToNotebookPageTitle >> whenIsSelectedChangedDo: aBlock [

	self property: #isSelected whenChangedDo: aBlock
]
