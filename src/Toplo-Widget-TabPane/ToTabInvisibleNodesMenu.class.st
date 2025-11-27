Class {
	#name : #ToTabInvisibleNodesMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabGroupElement'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #configuration }
ToTabInvisibleNodesMenu >> applyConfiguration [ 

	super applyConfiguration.
	self fitContent
]

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
