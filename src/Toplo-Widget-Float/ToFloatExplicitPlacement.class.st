Class {
	#name : #ToFloatExplicitPlacement,
	#superclass : #ToFloatPlacement,
	#instVars : [
		'anchors'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #accessing }
ToFloatExplicitPlacement >> anchors [

	^ anchors
]

{ #category : #accessing }
ToFloatExplicitPlacement >> anchors: anAnchorArray [

	anchors := anAnchorArray
]

{ #category : #configuration }
ToFloatExplicitPlacement >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors addAll: aFloat anchors ]
]
