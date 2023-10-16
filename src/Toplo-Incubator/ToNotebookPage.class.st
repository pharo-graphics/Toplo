Class {
	#name : 'ToNotebookPage',
	#superclass : 'Object',
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#isSelected => ObservableSlot',
		'#isCloseable => ObservableSlot',
		'#titleElement',
		'#bodyBuilder => ObservableSlot'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'accessing' }
ToNotebookPage >> bodyBuilder [

	^ bodyBuilder
]

{ #category : 'accessing' }
ToNotebookPage >> bodyBuilder: aValuable [
	"Establish what is my body. When a page is selected in a notebook, it will send `#value` to this factory, and use the answered `BlElement` as the page's body."

	bodyBuilder := aValuable
]

{ #category : 'accessing' }
ToNotebookPage >> bodyElement [

	^ bodyBuilder value
]

{ #category : 'accessing' }
ToNotebookPage >> bodyElement: aBlElement [

	self bodyBuilder: [ aBlElement ]
]

{ #category : 'accessing' }
ToNotebookPage >> closeButton [
	
	^ titleElement childWithId: #closeButton
]

{ #category : 'initialization' }
ToNotebookPage >> initialize [

	super initialize.
	self class initializeSlots: self.
	
	isSelected := false.
	isCloseable := false.
	bodyBuilder := [ BlElement new ]
]

{ #category : 'accessing' }
ToNotebookPage >> isCloseable [

	^ isCloseable
]

{ #category : 'accessing' }
ToNotebookPage >> isCloseable: aBoolean [

	isCloseable := aBoolean
]

{ #category : 'accessing' }
ToNotebookPage >> isSelected [

	^ isSelected
]

{ #category : 'accessing' }
ToNotebookPage >> isSelected: aBoolean [

	isSelected := aBoolean.
	aBoolean ifTrue: [ titleElement switchToSkinState: ToCheckedState new ] ifFalse: [ titleElement switchToSkinState: ToUncheckedState new ]
]

{ #category : 'accessing' }
ToNotebookPage >> titleElement [

	^ titleElement
]

{ #category : 'accessing' }
ToNotebookPage >> titleElement: aBlElement [

	titleElement := aBlElement
]

{ #category : 'enumerating' }
ToNotebookPage >> whenBodyBuilderChangedDo: aBlock [

	self property: #bodyBuilder whenChangedDo: aBlock
]

{ #category : 'events' }
ToNotebookPage >> whenIsCloseableChangedDo: aBlock [

	self property: #isCloseable whenChangedDo: aBlock
]

{ #category : 'events' }
ToNotebookPage >> whenIsSelectedChangedDo: aBlock [

	self property: #isSelected whenChangedDo: aBlock
]
