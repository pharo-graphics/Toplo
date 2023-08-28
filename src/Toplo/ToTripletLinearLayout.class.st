Class {
	#name : #ToTripletLinearLayout,
	#superclass : #BlLinearLayout,
	#instVars : [
		'frontAlignmentSpacing'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #orientation }
ToTripletLinearLayout >> beHorizontal [
	"Change my orientation to horizontal"
	
	self orientation: ToTripletLinearLayoutHorizontalOrientation new
]

{ #category : #accessing }
ToTripletLinearLayout >> frontAlignmentSpacing [ 

	^ frontAlignmentSpacing
]

{ #category : #accessing }
ToTripletLinearLayout >> frontAlignmentSpacing: aNumber [

	frontAlignmentSpacing := aNumber asFloat 
]

{ #category : #initialization }
ToTripletLinearLayout >> initialize [ 

	super initialize.
 	frontAlignmentSpacing := 0.0
]
