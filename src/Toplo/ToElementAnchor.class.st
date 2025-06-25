Class {
	#name : #ToElementAnchor,
	#superclass : #ToAnchor,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

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
		  baseAnchor: self;
		  targetAnchor: anAnchor;
		  yourself
]
