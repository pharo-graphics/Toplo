Class {
	#name : #ToTabsInvisibleItemsMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabsElement'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #skin }
ToTabsInvisibleItemsMenu >> newRawSkin [

	^ ToTabsInvisibleItemsMenuSkin new


]

{ #category : #accessing }
ToTabsInvisibleItemsMenu >> tabsElement [

	^ tabsElement
]

{ #category : #accessing }
ToTabsInvisibleItemsMenu >> tabsElement: aTabsElement [

	tabsElement := aTabsElement
]
