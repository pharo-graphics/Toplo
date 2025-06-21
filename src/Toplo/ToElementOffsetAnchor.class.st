Class {
	#name : #ToElementOffsetAnchor,
	#superclass : #ToElementAnchor,
	#instVars : [
		'baseAnchor',
		'offsetBlock'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementOffsetAnchor >> baseAnchor [

	^ baseAnchor
]

{ #category : #accessing }
ToElementOffsetAnchor >> baseAnchor: anObject [

	baseAnchor := anObject
]

{ #category : #accessing }
ToElementOffsetAnchor >> element [
	^ baseAnchor element
]

{ #category : #accessing }
ToElementOffsetAnchor >> offsetBlock [

	^ offsetBlock
]

{ #category : #accessing }
ToElementOffsetAnchor >> offsetBlock: anObject [

	offsetBlock := anObject
]

{ #category : #evaluating }
ToElementOffsetAnchor >> value [
	^ offsetBlock value: baseAnchor value
]
