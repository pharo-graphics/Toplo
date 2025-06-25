Class {
	#name : #ToElementAnchor,
	#superclass : #ToAnchor,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToElementAnchor >> element [

	^ element
]

{ #category : #accessing }
ToElementAnchor >> element: anElement [

	element := anElement
]

{ #category : #'instance creation' }
ToElementAnchor >> on: anAnchor [

	^ ToAnchorLayoutOperation new
		  leftHandSideAnchor: self;
		  rightHandSideAnchor: anAnchor;
		  yourself
]
