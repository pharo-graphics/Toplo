Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToPasteUpPane + TToElementWithPlaceholder',
	#classTraits : 'TToOrientable classTrait + TToPasteUpPane classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'lockedWidth'
	],
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

{ #category : #dividers }
ToPane >> dividers [

	^ self children select: [ :child | child isKindOf: ToDivider ]
]

{ #category : #initialization }
ToPane >> initialize [ 

	super initialize.
	lockedWidth := false
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

{ #category : #accessing }
ToPane >> lockedWidth [

	lockedWidth 
]

{ #category : #accessing }
ToPane >> lockedWidth: aBoolean [

	lockedWidth := aBoolean
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
