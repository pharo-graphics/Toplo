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
	divider := ToDivider between: aFirstElement and: aSecondElement in: self.
	self addChild: divider
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
ToPane >> privateAnnouncer: anObject [

	privateAnnouncer := anObject
]

{ #category : #accessing }
ToPane >> privateAnnouncerIsPlugged: anObject [

	privateAnnouncerIsPlugged := anObject
]
