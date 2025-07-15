Class {
	#name : #ToTabInvisibleNodeMenuItem,
	#superclass : #ToMenuItem,
	#instVars : [
		'tabNode'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #skin }
ToTabInvisibleNodeMenuItem >> newRawSkin [ 

	^ ToTabInvisibleNodeMenuItemSkin new
]

{ #category : #accessing }
ToTabInvisibleNodeMenuItem >> tabNode [

	^ tabNode
]

{ #category : #accessing }
ToTabInvisibleNodeMenuItem >> tabNode: aTabNode [

	tabNode := aTabNode
]
