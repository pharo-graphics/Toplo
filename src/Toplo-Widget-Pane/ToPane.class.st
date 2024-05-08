Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToPasteUpPane + TToElementWithPlaceholder',
	#classTraits : 'TToOrientable classTrait + TToPasteUpPane classTrait + TToElementWithPlaceholder classTrait',
	#category : #'Toplo-Widget-Pane'
}

{ #category : #factory }
ToPane class >> horizontal [

	^ self new
		  beHorizontal;
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #factory }
ToPane class >> vertical [

	^ self new
		  beVertical;
		  hFitContent;
		  vMatchParent;
		  yourself
]

{ #category : #dividers }
ToPane >> addDividerBetween: aFirstElement and: aSecondElement [

	| divider |
	divider := ToDivider between: aFirstElement and: aSecondElement in: self.
	self addChild: divider
]

{ #category : #dividers }
ToPane >> addDividers [

	| lastIdx |
	lastIdx := self children size.
	self children withIndexDo: [ :child :idx |
		idx < lastIdx ifTrue: [
			self addDividerBetween: child and: (self children at: idx + 1) ] ]
]

{ #category : #initialization }
ToPane >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #skin }
ToPane >> installBeeStyle [ 

	super installBeeStyle.
	self background: (self valueOfTokenNamed: #'background-color')
]

{ #category : #skin }
ToPane >> installRawStyle [ 

	super installRawStyle.
	self background: (self valueOfTokenNamed: #'background-color')
]

{ #category : #'t - orientable - accessing' }
ToPane >> layoutStrategy [

	^ self layout


]

{ #category : #layout }
ToPane >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self layout layoutIgnored: self context: aBlElementBoundsUpdateContext

]

{ #category : #dividers }
ToPane >> removeDividers [

	self removeChildren: (self children select: [ :child |
		child isKindOf: ToDivider ])
]

{ #category : #'api - resizer' }
ToPane >> transposeResizer [

	self constraintsDo: [ :c |
		c horizontal isMatchParent
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [
			c horizontal isFitContent ifTrue: [ c horizontal matchParent ] ].
		c vertical isMatchParent
			ifTrue: [ c vertical fitContent ]
			ifFalse: [
			c vertical isFitContent ifTrue: [ c vertical matchParent ] ] ]
]
