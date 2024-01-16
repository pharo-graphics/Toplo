Class {
	#name : #ToMultiSelectNode,
	#superclass : #ToSelectNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToMultiSelectNode >> initialize [ 

	super initialize.
	middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3).
]
