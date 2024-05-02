Class {
	#name : #ToSelectMultipleElementBarNodeContainerElement,
	#superclass : #ToMultipleSelectionElementBarNodeContainerElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectMultipleElementBarNodeContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToSelectMultipleElementBarNodeContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #'api - hooks' }
ToSelectMultipleElementBarNodeContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: anElementBar.
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	nodeWrapping
		ifTrue: [ innerNodeContainer addChild: textInputElement ]
		ifFalse: [ self addChild: textInputElement ]
]

{ #category : #'api - hooks' }
ToSelectMultipleElementBarNodeContainerElement >> onUninstalledIn: anElementBar [

	textInputElement onUninstalledIn: anElementBar.
	textInputElement removeFromParent.
	textInputElement := nil.
	super onUninstalledIn: anElementBar.

]

{ #category : #accessing }
ToSelectMultipleElementBarNodeContainerElement >> refresh [
	" first remove all data nodes "
	
	super refresh.
	textInputElement requestLayout
]

{ #category : #accessing }
ToSelectMultipleElementBarNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
