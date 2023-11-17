Class {
	#name : 'ToNotebookPage',
	#superclass : 'Object',
	#traits : 'TToElementWithCheckable + TToElementWithCheckableGroup',
	#classTraits : 'TToElementWithCheckable classTrait + TToElementWithCheckableGroup classTrait',
	#instVars : [
		'bodyBuilder',
		'closeable',
		'pageButton'
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
ToNotebookPage >> button [

	^ pageButton
]

{ #category : 'accessing' }
ToNotebookPage >> button: aPageButton [

	pageButton := aPageButton
]

{ #category : 't - checkable - accessing' }
ToNotebookPage >> checkable [

	^ self button
]

{ #category : 'accessing' }
ToNotebookPage >> closeable: aBoolean [

	closeable := aBoolean.
	aBoolean
		ifTrue: [
			| but |
			but := ToButton new.
			but defaultSkin: ToNotebookPageInnerCloseButtonSkin new.
			but icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #windowClose)).
			but constraintsDo: [ :c | c linear vertical alignCenter ].
			but when: BlClickEvent do: [ self button removeFromParent ].
			self button addChild: but as: #innerCloseButton ]
		ifFalse: [ self button removeChildNamed: #innerCloseButton ]
]

{ #category : 'initialization' }
ToNotebookPage >> initialize [

	super initialize.

	closeable := false.
	bodyBuilder := [ BlElement new ]
]

{ #category : 'accessing' }
ToNotebookPage >> innerCloseButton [
	
	^ pageButton childWithId: #innerCloseButton
]

{ #category : 'accessing' }
ToNotebookPage >> isCloseable [

	^ closeable
]

{ #category : 'accessing' }
ToNotebookPage >> isSelected [

	^ self isChecked
]

{ #category : 'accessing' }
ToNotebookPage >> selected: aBoolean [

	self checked: aBoolean
]

{ #category : 'event management' }
ToNotebookPage >> when: anEvent do: aBlock [

	self button when: anEvent do: aBlock
]
