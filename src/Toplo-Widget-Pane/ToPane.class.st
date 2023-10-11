Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToElementWithLayers + TToWidgetWithPlaceholder',
	#classTraits : 'TToOrientable classTrait + TToElementWithLayers classTrait + TToWidgetWithPlaceholder classTrait',
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

{ #category : #'t - widget - initialization' }
ToPane >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #'t - skinable - initialization' }
ToPane >> defaultStyleStamps [

	^ #( #pane )
]

{ #category : #'t - element with layers - accessing' }
ToPane >> layerReferentElement [

	^ self
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
