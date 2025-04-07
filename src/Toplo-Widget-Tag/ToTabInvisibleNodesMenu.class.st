Class {
	#name : #ToTabInvisibleNodesMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabGroupElement'
	],
	#category : #'Toplo-Widget-Tag-Tab'
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
