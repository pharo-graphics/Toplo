Class {
	#name : #ToSelectElementBar,
	#superclass : #ToElementBar,
	#instVars : [
		'filtrable',
		'windowManager'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectElementBar >> filterString [ 

	^ nodeContainer filterString
]

{ #category : #accessing }
ToSelectElementBar >> filtrable [

	^ filtrable
]

{ #category : #accessing }
ToSelectElementBar >> filtrable: aBoolean [

	filtrable := aBoolean.
	aBoolean
		ifTrue: [ self textInputElement beEditable ]
		ifFalse: [ self textInputElement beReadonly ].
]

{ #category : #initialization }
ToSelectElementBar >> initialize [

	super initialize.
	filtrable := true.
	nodeWrapping := true.

	self id: #headerElement
]

{ #category : #testing }
ToSelectElementBar >> isFiltrable [ 

	^ filtrable
]

{ #category : #accessing }
ToSelectElementBar >> multipleSelection: aBoolean [

	super multipleSelection: aBoolean.
	windowManager listElement selectionMode multiple: aBoolean
]

{ #category : #'instance creation' }
ToSelectElementBar >> newMultipleSelectionNodeContainer [

	^  ToSelectMultipleElementBarNodeContainerElement new
]

{ #category : #'instance creation' }
ToSelectElementBar >> newNodeContainer [

	^ super newNodeContainer
		  id: #nodeContainer;
		  yourself
]

{ #category : #window }
ToSelectElementBar >> onWindowClosed [

	self nodeContainer onWindowClosed
]

{ #category : #window }
ToSelectElementBar >> onWindowOpened [

	self nodeContainer onWindowOpened
]

{ #category : #accessing }
ToSelectElementBar >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToSelectElementBar >> sieve [

	^ windowManager sieve
]

{ #category : #accessing }
ToSelectElementBar >> textInputElement [ 

	^ nodeContainer textInputElement
]

{ #category : #accessing }
ToSelectElementBar >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectElementBar >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
