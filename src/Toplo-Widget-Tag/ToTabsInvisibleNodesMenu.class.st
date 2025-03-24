Class {
	#name : #ToTabsInvisibleNodesMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabsElement'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #skin }
ToTabsInvisibleNodesMenu >> newRawSkin [

	^ ToTabsInvisibleNodesMenuSkin new


]

{ #category : #accessing }
ToTabsInvisibleNodesMenu >> tabsElement [

	^ tabsElement
]

{ #category : #accessing }
ToTabsInvisibleNodesMenu >> tabsElement: aTabsElement [

	tabsElement := aTabsElement
]
