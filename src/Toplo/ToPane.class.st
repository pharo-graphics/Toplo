"
I'm a container with a linear layout. (see `BlLinearLayout` comments)
"
Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToOrientable',
	#classTraits : 'TToWidget classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Pane'
}

{ #category : #adding }
ToPane >> addDividerBetween: aFirstElement and: aSecondElement [

	| divider |
	self isHorizontal ifFalse: [ 
	divider := ToDivider horizontal.
	self whenLayoutedDoOnce: [
		| firstY secondY gap |
		firstY := aFirstElement bounds bottom.
		secondY := aSecondElement bounds top.
		gap := secondY - firstY / 2 - (divider thickness / 2).
		divider relocate: divider position x @ firstY + gap.
		divider width: self width.
		self addChild: divider.
		]. ^ self  ].
	divider := ToDivider vertical.
	self whenLayoutedDoOnce: [
		| firstX secondX gap |
		firstX := aFirstElement bounds right.
		secondX := aSecondElement bounds left.
		gap := secondX - firstX / 2 - (divider thickness / 2).
		divider relocate:  firstX + gap @ divider position y.
		divider height: self height.
		self addChild: divider]

]

{ #category : #adding }
ToPane >> addDividers [

	| lastIdx |
	lastIdx := self children size.
	self children withIndexDo: [ :child :idx |
		idx < lastIdx ifTrue: [
			self addDividerBetween: child and: (self children at: idx + 1) ] ]
]

{ #category : #'t - initialization' }
ToPane >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #accessing }
ToPane >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToPane >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToPane >> privateAnnouncer: anObject [

	privateAnnouncer := anObject
]

{ #category : #accessing }
ToPane >> privateAnnouncerIsPlugged: anObject [

	privateAnnouncerIsPlugged := anObject
]

{ #category : #accessing }
ToPane >> verticalAlignment [
	<return: #BlElementAlignment>

	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToPane >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]
