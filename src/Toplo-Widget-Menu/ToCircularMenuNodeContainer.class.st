Class {
	#name : #ToCircularMenuNodeContainer,
	#superclass : #ToAnnulusSectorElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #accessing }
ToCircularMenuNodeContainer >> holder: anHolder [

	super holder: anHolder.
	node := ToCircularMenuNode new.
	node holder: anHolder.
	node constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				(c anchors centerAnchor on: c anchors parent centroidAnchor) ].
	self addChild: node
]

{ #category : #initialization }
ToCircularMenuNodeContainer >> initialize [

	super initialize.
	self border: Color lightGray.
	self background: (Color random alpha: 0.1).
	self constraintsDo: [ :c | c annulus angleGap: 30 ].
	self addEventHandlerOn: BlMouseLeaveEvent do: [
			self holder listElement secondarySelecter deselectAll.
			self holder listElement requestLayout ]
]

{ #category : #accessing }
ToCircularMenuNodeContainer >> node [ 

	^ node
]
