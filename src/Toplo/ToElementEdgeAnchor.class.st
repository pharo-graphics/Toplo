Class {
	#name : #ToElementEdgeAnchor,
	#superclass : #ToElementAnchor,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementEdgeAnchor >> element [

	^ element
]

{ #category : #accessing }
ToElementEdgeAnchor >> element: anElement [

	element := anElement
]

{ #category : #'instance creation' }
ToElementEdgeAnchor >> on: anAnchor [

	^ ToAnchorLayoutOperation new
		  baseAnchor: self;
		  targetAnchor: anAnchor;
		  yourself
]

{ #category : #'instance creation' }
ToElementEdgeAnchor >> onBottomAnchor [

	^ self on: ToElementBottomAnchor new
]

{ #category : #'instance creation' }
ToElementEdgeAnchor >> onLeftAnchor [

	^ self on: ToElementLeftAnchor new
]

{ #category : #'instance creation' }
ToElementEdgeAnchor >> onRightAnchor [

	^ self on: ToElementRightAnchor new
]

{ #category : #'instance creation' }
ToElementEdgeAnchor >> onTopAnchor [

	^ self on: ToElementTopAnchor new
]

{ #category : #applying }
ToElementEdgeAnchor >> read: aRectangle [

	^ self subclassResponsibility
]

{ #category : #applying }
ToElementEdgeAnchor >> translate: aRectangle to: aValue [

	^ self subclassResponsibility
]
