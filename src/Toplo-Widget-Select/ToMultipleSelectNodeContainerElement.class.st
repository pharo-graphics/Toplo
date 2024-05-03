Class {
	#name : #ToMultipleSelectNodeContainerElement,
	#superclass : #ToMultipleSelectionElementBarNodeContainerElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToMultipleSelectNodeContainerElement >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #initialization }
ToMultipleSelectNodeContainerElement >> defaultNodeClass [ 

	^ ToMultipleSelectNode
]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #'api - hooks' }
ToMultipleSelectNodeContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: self.
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	nodeWrapping
		ifTrue: [ innerNodeContainer addChild: textInputElement after: fakeNode ]
		ifFalse: [ self addChild: textInputElement ]
]

{ #category : #'api - hooks' }
ToMultipleSelectNodeContainerElement >> onUninstalledIn: anElementBar [

	textInputElement onUninstalledIn: anElementBar.
	textInputElement removeFromParent.
	textInputElement := nil.
	super onUninstalledIn: anElementBar.

]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> refresh [
	" first remove all data nodes "
	
	super refresh.
	textInputElement requestLayout
]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
