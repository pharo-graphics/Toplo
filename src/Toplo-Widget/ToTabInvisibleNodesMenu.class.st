Class {
	#name : #ToTabInvisibleNodesMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabGroupElement'
	],
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #skin }
ToTabInvisibleNodesMenu >> newRawSkin [

	^ ToTabInvisibleNodesMenuSkin new


]

{ #category : #accessing }
ToTabInvisibleNodesMenu >> tabGroupElement [

	^ tabGroupElement
]

{ #category : #accessing }
ToTabInvisibleNodesMenu >> tabGroupElement: aTabGroupElement [

	tabGroupElement := aTabGroupElement
]
