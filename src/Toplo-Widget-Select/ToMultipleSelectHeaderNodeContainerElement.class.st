Class {
	#name : #ToMultipleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^ ToMultipleSelectHeaderNode
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: select.
	textInputElement hFitContent.
	self addChild: textInputElement.
	self initializeFakeNode
]
