Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabPaneGroupElement >> barElementClass [

	^ ToTabPaneBarElement 
]

{ #category : #adding }
ToTabPaneGroupElement >> newTabItem [

	^ ToTabButton new
]
