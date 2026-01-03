Class {
	#name : #ToTreeNodeContainer,
	#superclass : #ToNodeContainer,
	#instVars : [
		'arrowButton',
		'indentFiller'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeNodeContainer >> arrowButton [

	^ arrowButton
]

{ #category : #accessing }
ToTreeNodeContainer >> arrowButton: anObject [

	arrowButton ifNotNil: [
		(BlImmutableObjectChangeError object: self) signal ].
	arrowButton := anObject.
	arrowButton id: #arrowButton.
	self startContainer addChild: arrowButton
]

{ #category : #'instance creation' }
ToTreeNodeContainer >> createArrowButton [

	| aWrapper btn |
	self indentFiller: self newFiller.
	aWrapper := self holder dataWrapper.
	btn := ToIconicArrowButton none.
	aWrapper hasLeafDataItem ifFalse: [
			btn := aWrapper isExpanded
				       ifFalse: [ ToIconicArrowButton right ]
				       ifTrue: [ ToIconicArrowButton down ].
			btn clickAction: [
				self dispatchEvent: ToArrowButtonClickedEvent new ] ].
	btn constraintsDo: [ :c |
			c linear horizontal alignLeft.
			c linear vertical alignCenter ].
	self arrowButton: btn
]

{ #category : #testing }
ToTreeNodeContainer >> hasLeafDataItem [

	^ self holder dataWrapper hasLeafDataItem
]

{ #category : #'instance creation' }
ToTreeNodeContainer >> indentFiller [

	^ indentFiller
]

{ #category : #'instance creation' }
ToTreeNodeContainer >> indentFiller: anElement [

	indentFiller ifNotNil: [
		(BlImmutableObjectChangeError object: self) signal ].
	indentFiller := anElement.
	indentFiller id: #indentFiller.
	self startContainer addChild: indentFiller
]

{ #category : #accessing }
ToTreeNodeContainer >> indentWidth [

	^ self indentFiller ifNotNil: [ :if | if width ] ifNil: [ 0 ]
]

{ #category : #accessing }
ToTreeNodeContainer >> indentWidth: aNumber [

	self indentFiller width: aNumber
]

{ #category : #initialization }
ToTreeNodeContainer >> initialize [

	super initialize.
	self addEventHandlerOn: ToArrowButtonClickedEvent do: [ :event |
			event consume.
			self toggle ]
]

{ #category : #skin }
ToTreeNodeContainer >> newRawSkin [ 
	
	^ ToTreeNodeContainerSkin new
]

{ #category : #accessing }
ToTreeNodeContainer >> nodeDepth [
	" in case I am the node container of the fake node container, my data wrapper is nil"

	^ self holder dataWrapper
		  ifNil: [ 0 ]
		  ifNotNil: [ :dw | dw nodeDepth ]
]

{ #category : #testing }
ToTreeNodeContainer >> toggle [

	^ self holder dataWrapper toggle
]
