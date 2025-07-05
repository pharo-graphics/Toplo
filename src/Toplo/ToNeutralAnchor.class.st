Class {
	#name : #ToNeutralAnchor,
	#superclass : #ToElementAnchor,
	#instVars : [
		'neutralValue'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToNeutralAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ aRectangle
]

{ #category : #accessing }
ToNeutralAnchor >> neutralValue [

	^ neutralValue
]

{ #category : #accessing }
ToNeutralAnchor >> neutralValue: anObject [

	neutralValue := anObject
]

{ #category : #applying }
ToNeutralAnchor >> readRectangle: aRectangle [

	^ neutralValue
]
