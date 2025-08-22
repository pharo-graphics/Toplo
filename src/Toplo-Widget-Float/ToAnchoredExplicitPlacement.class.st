Class {
	#name : #ToAnchoredExplicitPlacement,
	#superclass : #ToAnchoredPlacement,
	#instVars : [
		'constraintsAction'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredExplicitPlacement >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			constraintsAction value: c ]
]

{ #category : #accessing }
ToAnchoredExplicitPlacement >> constraintsAction: aValuable [ 

	constraintsAction := aValuable
]
