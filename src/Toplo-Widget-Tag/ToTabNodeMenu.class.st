Class {
	#name : #ToTabNodeMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabsElement'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #accessing }
ToTabNodeMenu >> newRawSkin [ 

	^ ToTabNodeMenuSkin new
]

{ #category : #accessing }
ToTabNodeMenu >> tabsElement [

	^ tabsElement
]

{ #category : #accessing }
ToTabNodeMenu >> tabsElement: anObject [

	tabsElement := anObject
]
