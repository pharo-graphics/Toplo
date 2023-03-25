Class {
	#name : #ToNotebookPage,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#isSelected => ObservableSlot',
		'#isCloseable => ObservableSlot',
		'#titleElement',
		'#bodyElement'
	],
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #accessing }
ToNotebookPage >> bodyElement [

	^ bodyElement
]

{ #category : #accessing }
ToNotebookPage >> bodyElement: aBlElement [

	bodyElement := aBlElement
]

{ #category : #accessing }
ToNotebookPage >> closeButton [
	
	^ titleElement childWithId: #closeButton
]

{ #category : #initialization }
ToNotebookPage >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	isSelected := false.
	isCloseable := false.
]

{ #category : #accessing }
ToNotebookPage >> isCloseable [

	^ isCloseable
]

{ #category : #accessing }
ToNotebookPage >> isCloseable: aBoolean [

	isCloseable := aBoolean
]

{ #category : #accessing }
ToNotebookPage >> isSelected [

	^ isSelected
]

{ #category : #accessing }
ToNotebookPage >> isSelected: aBoolean [

	isSelected := aBoolean
]

{ #category : #accessing }
ToNotebookPage >> titleElement [

	^ titleElement
]

{ #category : #accessing }
ToNotebookPage >> titleElement: aBlElement [

	titleElement := aBlElement
]

{ #category : #events }
ToNotebookPage >> whenIsCloseableChangedDo: aBlock [

	self property: #isCloseable whenChangedDo: aBlock
]

{ #category : #events }
ToNotebookPage >> whenIsSelectedChangedDo: aBlock [

	self property: #isSelected whenChangedDo: aBlock
]
