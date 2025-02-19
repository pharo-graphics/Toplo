"
I'm a pane that can contains other elements. 
I can have dividers in between my elements.
"
Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToWithOrientableLayout + TToPasteUpPane + TToElementWithPlaceholder',
	#classTraits : 'TToWithOrientableLayout classTrait + TToPasteUpPane classTrait + TToElementWithPlaceholder classTrait',
	#category : #'Toplo-Widget-Pane-Core'
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

{ #category : #dividers }
ToPane >> dividers [

	^ self children select: [ :child | child isKindOf: ToDivider ]
]

{ #category : #skin }
ToPane >> installRawStyle [

	super installRawStyle.
	self background: (self valueOfTokenNamed: #'background-color').
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: #'border-radius'))
]

{ #category : #layout }
ToPane >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self layout layoutIgnored: self context: aBlElementBoundsUpdateContext

]

{ #category : #dividers }
ToPane >> removeDividers [

	self removeChildren: self dividers
]

{ #category : #dividers }
ToPane >> subpanes [

	^ self children select: [ :child | child isKindOf: ToPane ]
]
