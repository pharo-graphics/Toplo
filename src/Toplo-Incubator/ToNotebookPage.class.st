Class {
	#name : #ToNotebookPage,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#isSelected => ObservableSlot',
		'#isCloseable => ObservableSlot',
		'#titleElement',
		'#title',
		'#bodyFactory => ObservableSlot'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #accessing }
ToNotebookPage >> bodyElement [

	^ bodyFactory value
]

{ #category : #accessing }
ToNotebookPage >> bodyElement: aBlElement [

	self bodyFactory: [ aBlElement ]
]

{ #category : #accessing }
ToNotebookPage >> bodyFactory [

	^ bodyFactory
]

{ #category : #accessing }
ToNotebookPage >> bodyFactory: aValuable [
	"Establish what is my body. When a page is selected in a notebook, it will send `#value` to this factory, and use the answered `BlElement` as the page's body."

	bodyFactory := aValuable
]

{ #category : #accessing }
ToNotebookPage >> closeButton [
	
	^ titleElement childWithId: #closeButton
]

{ #category : #initialization }
ToNotebookPage >> initialize [

	super initialize.
	self class initializeSlots: self.
	
	isSelected := false.
	isCloseable := false.
	bodyFactory := [ BlElement new ]
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
ToNotebookPage >> title [

	^ title
]

{ #category : #accessing }
ToNotebookPage >> title: aString [

	title := aString
]

{ #category : #accessing }
ToNotebookPage >> titleElement [

	^ titleElement
]

{ #category : #accessing }
ToNotebookPage >> titleElement: aBlElement [

	titleElement := aBlElement
]

{ #category : #enumerating }
ToNotebookPage >> whenBodyFactoryChangedDo: aBlock [

	self property: #bodyFactory whenChangedDo: aBlock
]

{ #category : #events }
ToNotebookPage >> whenIsCloseableChangedDo: aBlock [

	self property: #isCloseable whenChangedDo: aBlock
]

{ #category : #events }
ToNotebookPage >> whenIsSelectedChangedDo: aBlock [

	self property: #isSelected whenChangedDo: aBlock
]
