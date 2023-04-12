Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToOrientable + TToWidgetWithLayers + TToWidgetWithPlaceholder',
	#classTraits : 'TToWidget classTrait + TToOrientable classTrait + TToWidgetWithLayers classTrait + TToWidgetWithPlaceholder classTrait',
	#category : #'Toplo-Widget-Pane'
}

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

{ #category : #'t - initialization dresser' }
ToPane >> defaultDresser [ 

	^ ToPaneDresser
]

{ #category : #'t - initialization' }
ToPane >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #initialization }
ToPane >> initialize [

	self class initializeSlots: self.
	super initialize
]

{ #category : #'t - accessing layers' }
ToPane >> layerReferentElement [

	^ self
]

{ #category : #layout }
ToPane >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self layout layoutIgnored: self context: aBlElementBoundsUpdateContext

]

{ #category : #accessing }
ToPane >> privateAnnouncer: anObject [

	privateAnnouncer := anObject
]

{ #category : #accessing }
ToPane >> privateAnnouncerIsPlugged: anObject [

	privateAnnouncerIsPlugged := anObject
]
