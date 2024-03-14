Class {
	#name : #ToSingleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'headerNode'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder | ]
]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^  ToSingleSelectHeaderNode
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	headerNode := self newHeaderNode.
	self headerNodeBuilder value: headerNode value: headerNode selectHolder.
	self addChild: headerNode.
	headerNode onInstalledIn: select.
	self initializeFakeNode
]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> textInputElement [

	^ headerNode textInputElement
]
