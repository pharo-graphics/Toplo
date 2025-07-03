Class {
	#name : #ToActionAnchor,
	#superclass : #ToAnchor,
	#instVars : [
		'baseAnchor',
		'action'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToActionAnchor >> action: aValuable [

	action := aValuable
]

{ #category : #applying }
ToActionAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ baseAnchor
		  appliedOnRectangle: aRectangle
		  withValue: (action value: aValue)
]

{ #category : #accessing }
ToActionAnchor >> baseAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
ToActionAnchor >> element [

	^ baseAnchor element
]

{ #category : #applying }
ToActionAnchor >> readRectangle: aRectangle [ 

	^ action value: (baseAnchor readRectangle: aRectangle )
]
